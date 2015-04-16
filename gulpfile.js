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
  components: {
    src:  'app/coffee/components/*.cjsx',
    dest: 'app/js'
  },
  stores: {
    src:  'app/coffee/stores/*.coffee',
    dest: 'app/js'
  },
  cjsx: {
    src:  'app/coffee/*.cjsx',
    dest: 'app/js'
  },
  coffee: {
    src:  'app/coffee/*.coffee',
    dest: 'app/js'
  }
};

gulp.task('styles', function() {
  return gulp.src(paths.styles.src)
    .pipe(sass({errLogToConsole: true}))
    .pipe(autoprefixer(['last 2 versions', "ie 8"]))
    .pipe(gulp.dest(paths.styles.dest));
});

gulp.task('components', function() {
  return gulp.src(paths.components.src)
    .pipe(cjsx().on('error', gutil.log))
    .pipe(concat('components.js'))
    .pipe(gulp.dest(paths.components.dest));
});

gulp.task('stores', function() {
  return gulp.src(paths.stores.src)
    .pipe(coffee().on('error', gutil.log))
    .pipe(concat('stores.js'))
    .pipe(gulp.dest(paths.stores.dest));
});

gulp.task('coffee', function() {
  return gulp.src(paths.coffee.src)
    .pipe(coffee().on('error', gutil.log))
    .pipe(gulp.dest(paths.coffee.dest));
});

gulp.task('cjsx', function() {
  return gulp.src(paths.cjsx.src)
    .pipe(cjsx().on('error', gutil.log))
    .pipe(gulp.dest(paths.cjsx.dest));
});

gulp.task('watch', function() {
  gulp.watch(paths.components.src, ['components']);
  gulp.watch(paths.stores.src, ['stores']);
  gulp.watch(paths.cjsx.src,   ['cjsx']);
  gulp.watch(paths.coffee.src, ['coffee']);
  gulp.watch(paths.styles.src, ['styles']);
});

gulp.task('scripts', ['components', 'stores', 'coffee', 'cjsx']);
gulp.task('default', ['styles', 'scripts', 'watch']);

