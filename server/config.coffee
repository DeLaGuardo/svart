module.exports =
  development:
    port: 3000
    redis:
      port: 6379
      host: 'localhost'
    mongo:
      port: 27017
      host: 'localhost'
      db: 'dev_svart'
    store:
      port: 27017
      host: 'localhost'
      db: 'dev_svart_store'
    wsHost: 'localhost'
  production:
    port: 3005
    redis:
      port: 6379
      host: 'localhost'
    mongo:
      port: 27017
      host: 'localhost'
      db: 'prod_svart'
    store:
      port: 27017
      host: 'localhost'
      db: 'prod_svart_store'
    wsHost: 'localhost'
  test:
    port: 3006
    redis:
      port: 6379
      host: 'localhost'
    mongo:
      port: 27017
      host: 'localhost'
      db: 'test_svart'
    store:
      port: 27017
      host: 'localhost'
      db: 'test_svart_store'
    wsHost: 'localhost'
