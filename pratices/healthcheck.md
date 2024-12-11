# HEALTHCHECK no docker

Imagine que você está rodando um serviço importante dentro de um contêiner Docker. Tudo parece estar funcionando, mas um problema silencioso pode estar se escondendo. E se o serviço travar ou parar de responder, mas o contêiner continuar ativo? É aqui que o `HEALTHCHECK` entra em cena como seu amiguinho.

O comando `HEALTHCHECK` é uma ferramenta que permite monitorar de forma automatizada o status de um contêiner Docker. Com ele, você pode identificar rapidamente quando algo não está funcionando como deveria e agir antes que problemas maiores ocorram ou pelos menos ser informado!

## Por que usar o health check?

Pense no seguinte: um serviço "ativo" nem sempre significa que está funcionando. Pode estar lento, travado ou simplesmente indisponível para atender às requisições. Então o `HEALTHCHECK` faz essas verificações regulares para garantir que tudo está como deveria, trazendo benefícios como:

- **Automação:** Permite que o Docker ou orquestradores como docker swarm tomem decisões automáticas.
- **Confiabilidade:** Detecção rápida de falhas antes que prejudiquem o usuário final.
- **Visibilidade:** Facilita o monitoramento te trazendo o estado real do container.

## Estrutura básica do health check?

A configuração básica do comando segue este formato e é adicionado diretamente no Dockerfile:

```dockerfile
HEALTHCHECK [OPTIONS] CMD <comando>
```

Vamos ver um exemplo simples de como verificar se um serviço HTTP está rodando:

```dockerfile
HEALTHCHECK --interval=10s --timeout=3s --start-period=30s --retries=3 CMD curl -f http://localhost:3000/
```
Este comando verifica se o serviço responde na porta 3000 e considera qualquer código de status HTTP maior ou igual a 400 como uma falha.


### O que é cada parâmetro?

- **`--interval=10s`**: Intervalo entre as verificações (10 segundos).
- **`--timeout=3s`**: Tempo máximo para que o comando responda (3 segundos).
- **`--start-period=30s`**: Período inicial antes de iniciar os checks.
- **`--retries=3`**: Número de falhas consecutivas permitidas antes de marcar como "unhealthy".

Mesmo sendo uma ferramenta incrível, o `HEALTHCHECK` precisa ser usado com responsabilidade:

- **Evite checks muito frequentes:** Um intervalo muito curto pode sobrecarregar o serviço monitorado ou o próprio contêiner. Ajuste o `--interval` de acordo com a criticidade da aplicação.
- **Considere o tempo de inicialização:** Alguns serviços demoram para ficar totalmente disponíveis. Use o `--start-period` para evitar falhas falsas logo após o início.
- **Limite as tentativas:** Defina um número razoável de `--retries` para evitar loops desnecessários de tentativas.

## Como funciona o health check?

Assim, simples como voar.

1. O Docker executa o comando definido no `CMD` a cada intervalo configurado.
2. Se o comando retornar **0**, o contêiner é considerado "healthy".
3. Se o comando retornar qualquer outro valor, é registrada uma falha. Após atingir o limite de `--retries`, o contêiner é marcado como "unhealthy".

## Por que isso é importante?

Essa abordagem permite que problemas sejam identificados e tratados antes de afetar diretamente a operação de forma inesperada. (nada é, tudo depende OK!? não leve ao pé da letra).

Como um contêiner que "parece" vivo, saudável e funcional, pode não estar realmente respondendo. O health check bem planejado te ajuda em:

- Reinícios automáticos.
- Escalabilidade controlada.
- Diagnóstico rápido em casos de falhas.

Se você ainda não configurou `HEALTHCHECK` nos seus contêineres, está perdendo a chance de deixar seu ambiente mais resiliente e confiável.

Implementar essa prática é um pequeno esforço com grandes resultados para a estabilidade do seu sistema. Experimente e veja a diferença!


