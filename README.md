# Descrição

Para esse teste técnico escolhi utilizar o docker compose para facilitar rodar/testar a aplicação. 
Tanto o backend quanto o frontend encontram-se nesse mesmo repositório nas respectivas pastas 
**teste_tecnico_laager_backend/** e **teste_tecnico_laager_frontend/**, com os 
arquivos de setup/environment no diretório raiz (mesmo desse readme)

# O Projeto

- Para Backend foi utilizado **Rails** versão **7.1**, com Ruby versão **3.3.9**.<br>
  - Para ActionJob foi utilizado o Sidekiq com Redis
- Para Frontend foi utilizado **Vue.js** versão **3.5** com Node.js versão **22.11**
- Para servir a aplicação e balancear cargas, foi utilizado **Nginx** versão **1.29**
- Para TaskQueue, Cache e Backend do Action Cable foi utilizado **Redis** versão **8.2**
- Para Banco de Dados foi utilizado **Postgres** versão **17**
- Todos os serviços são orquestrados utilizando Docker Compose

# Setup

Obs: Para a gestão de versão do Ruby durante o desenvolvimento foi utilizado o [Mise](https://mise.jdx.dev/getting-started.html)

Na raiz dê o seguinte comando:
```shell
docker compose up --build 
```

## Testando

### API - Backend de Carga

Na raiz do projeto rode o script:
```shell
chmod +x ./testing.sh
./testing.sh
```

### API - Testes Unitário

Obs: Os Testes unitários não dependem aplicação toda rodando com o Docker Compose<br>
Na raiz do projeto rode o script:
```shell
cd ./teste_tecnico_laager_backend
chmod +x ./unit_tests.sh
./unit_tests.sh
```

# Acessando a Aplicação

Uma vez feito o [Setup](#setup) o Frontend da aplicação estará rodando em http://localhost:9999
e o Backend estará rodando em http://localhost:9999/api

## Endpoints

### POST /api/participants/{id}/upvote
Adiciona um voto na contagem para determinado participante (id).<br>
Dispara um ActionJob que computará o voto de forma assíncrona, além disso
após computar o voto dispara um _broadcast_ para **statistics_stream**

### GET /api/participants
Retorna uma lista de todos os participantes

### GET /api/participants/{id}
Retorna dados sobre um participante específico (id)

## Websockets

### POST /api/websocket
Apresenta as informações sobre os participantes e as estatísticas, acompanha em tempo real
as mudanças disparadas na Stream **statistics_stream** do ActionCable

#### body
```json
{
  "command": "subscribe",
  "identifier": "{\"channel\":\"StatisticsChannel\"}"
}
```