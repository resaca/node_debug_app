module.exports = (shipit) ->
  require('shipit-deploy') shipit
  require('shipit-pm2-nginx') shipit
  require('shipit-npm') shipit

  shipit.initConfig
    staging:
      servers: 'staging@myapp.eastus2.cloudapp.azure.com'
    default:
      name: 'myappme'
      workspace: '/tmp/shipit'
      deployTo: '/srv/apps/myappme'
      repositoryUrl: 'git@bitbucket.org:myapp/api-server.git'
      ignores: ['.git', 'node_modules']
      keepReleases: 5
      branch: 'staging'
      # shallowClone: true
      nginx:
        servername: 'myapp.eastus2.cloudapp.azure.com'
      pm2:
        conf:
          watch: true,
          script: 'app.coffee'

  shipit.task 'pwd', ->
    shipit.remote 'pwd'
  return
