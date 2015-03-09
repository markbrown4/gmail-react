// run 'npm install' and 'gulp'

var gulp =   require('gulp');
var gutil =  require('gulp-util');
var cjsx =   require('gulp-cjsx');
var coffee = require('gulp-coffee');
var concat = require('gulp-concat');
var sass =   require('gulp-sass');
var uglify = require('gulp-uglify');
var autoprefixer = require('gulp-autoprefixer');

var paths = {
  styles: {
    src:  'app/scss/**/*.scss',
    dest: 'app/css'
  },
  cjsx: {
    src:  'app/coffee/components/*.cjsx',
    dest: 'app/js'
  },
  coffee: {
    src:  'app/coffee/**/*.coffee',
    dest: 'app/js'
  }
};

gulp.task('styles', function() {
  return gulp.src(paths.styles.src)
    .pipe(sass({errLogToConsole: true}))
    .pipe(autoprefixer(['last 2 versions', "ie 8"]))
    .pipe(gulp.dest(paths.styles.dest));
});

gulp.task('cjsx', function() {
  return gulp.src(paths.cjsx.src)
    .pipe(cjsx({bare: true}).on('error', gutil.log))
    .pipe(concat('components.js'))
    .pipe(gulp.dest(paths.cjsx.dest));
});

gulp.task('coffee', function() {
  return gulp.src(paths.coffee.src)
    .pipe(coffee().on('error', gutil.log))
    .pipe(gulp.dest(paths.coffee.dest));
});

gulp.task('watch', function() {
  gulp.watch(paths.cjsx.src, ['cjsx']);
  gulp.watch(paths.coffee.src, ['coffee']);
  gulp.watch(paths.styles.src, ['styles']);
});

gulp.task('scripts', ['cjsx', 'coffee']);
gulp.task('default', ['styles', 'scripts', 'watch']);

