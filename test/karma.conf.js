module.exports = function(config){
  config.set({

    basePath : '../',

    preprocessors : {
        'app/js/**/*.js.coffee': 'coverage',
        'test/unit/**/*.js.coffee': 'coffee'
    },

    files : [
      'app/bower_components/angular/angular.js',
      'app/bower_components/angular-route/angular-route.js',
      'app/bower_components/angular-resource/angular-resource.js',
      'app/bower_components/angular-animate/angular-animate.js',
      'app/bower_components/angular-mocks/angular-mocks.js',
      'app/bower_components/angular-sanitize/angular-sanitize.js',
      'app/js/**/*.js.coffee',
      'app/js/*.js.coffee',
      'test/unit/**/*.js.coffee'
    ],

    autoWatch : true,
    colors: true,

    frameworks: ['mocha', 'chai'],

    browsers : ['Chrome'],

    reporters: ['mocha', 'coverage'],

    coverageReporter : {
        type : 'html',
        dir : 'coverage/'
    }

  });
};