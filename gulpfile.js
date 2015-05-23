// run 'npm install' and 'gulp'

var gulp =    require('gulp');
var gutil =   require('gulp-util');
var include = require('gulp-include');
var cjsx =    require('gulp-cjsx');
var gulpif =  require('gulp-if');
var coffee =  require('gulp-coffee');
var concat =  require('gulp-concat');
var sass =    require('gulp-sass');
var uglify =  require('gulp-uglify');
var autoprefixer = require('gulp-autoprefixer');

var paths = {
  scss: {
    src:  'app/scss/**/*.scss',
    dest: 'app/css'
  },
  coffee: {
    src: 'app/coffee/**/*.*',
    files:  [
      'app/coffee/framework/framework.coffee',
      'app/coffee/filters/**/*.coffee',
      'app/coffee/resources/**/*.coffee',
      'app/coffee/stores/**/*.coffee',
      'app/coffee/actions/**/*.coffee',
      'app/coffee/components/**/*.cjsx',
      'app/coffee/app.cjsx'
    ],
    dest: 'app/js'
  }
};

gulp.task('scss', function() {
  return gulp.src(paths.scss.src)
    .pipe(sass({errLogToConsole: true}))
    .pipe(autoprefixer(['last 2 versions', "ie 8"]))
    .pipe(gulp.dest(paths.scss.dest));
});

gulp.task('coffee', function() {
  return gulp.src(paths.coffee.files)
    .pipe(gulpif(/[.]coffee$/, include()))
    .pipe(gulpif(/[.]coffee$/, coffee()))
    .pipe(gulpif(/[.]cjsx$/, cjsx()))
    .pipe(concat('app.js'))
    .pipe(gulp.dest(paths.coffee.dest));
});

gulp.task('watch', function() {
  gulp.watch(paths.scss.src,   ['scss']);
  gulp.watch(paths.coffee.src, ['coffee']);
});

gulp.task('default', ['coffee', 'scss', 'watch']);

