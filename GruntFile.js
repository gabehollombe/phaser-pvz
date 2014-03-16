module.exports = function (grunt) {
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-connect');
    grunt.loadNpmTasks('grunt-open');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-browserify');
    // grunt.loadNpmTasks('grunt-notify');
    grunt.loadNpmTasks('grunt-contrib-jasmine');

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        connect: {
            server: {
                options: {
                    hostname: '*',
                    port: 8080,
                    base: '.'
                }
            }
        },
        coffee: {
          compile: {
            options: {
              sourceMap: true
            },
            expand: true,
            src: ['game/**/*.coffee'],
            dest: 'deploy/js/',
            ext: '.js'
          }
        },
        watch: {
          main: {
            files: '**/*.coffee',
            tasks: ['coffee', 'copy', 'browserify']
          },
        },
        open: {
            dev: {
                path: 'http://127.0.0.1:8080/deploy/'
            }
        },
        copy: {
          main: {
            files: [
              { expand: true, src: ['assets/**'], dest: 'deploy/' },
              { expand: true, src: ['lib/**'], dest: 'deploy/js/' }
            ]
          }
        },
        browserify: {
          game: {
            src: ['game/main.coffee'],
            dest: 'deploy/js/game/browserified-game.js',
            options: {
              //transform: ['coffeeify', 'uglifyify'],
              transform: ['coffeeify'],
              debug: true
            }
          }
        }
        // uglify: {
        //   game: {
        //     files: {
        //       'deploy/browserified-game.min.js': ['deploy/browjk.js', 'src/input2.js']
        //     }
        //   }
        // }
    });

    grunt.registerTask('default', ['browserify', 'copy', 'connect', 'open', 'watch:main', 'watch:src']);
};
