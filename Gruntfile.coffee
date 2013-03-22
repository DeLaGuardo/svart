module.exports = (grunt) ->
  grunt.initConfig
    sass:
      dist:
        files: {
          'client/css/style.css':'client/css/style.scss'
        }
      dev:
        options:
          style: 'expanded'
        files:
          'client/css/style-dev.css': 'client/css/style.scss'

  grunt.loadNpmTasks 'grunt-contrib-sass'

  grunt.registerTask 'default', ['sass:dist']
