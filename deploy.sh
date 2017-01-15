#!/bin/sh

git remote add deploy git@github.com:lucproglangcourse/lucproglangcourse.github.io.git
git fetch deploy
git reset deploy/gh-pages
git checkout master source Makefile build.sh
rm -rf build
./build.sh
if [ $? -eq 0 ]
then
  mkdir -p download
  mv -f build/html/* ./
  mv -f build/latex/*.pdf ./download/
  mv -f build/epub/*.epub ./download/
  touch .nojekyll
  git log master --pretty=short --abbrev-commit > COMMITS.txt
  git add -A
  git commit -m "Generated gh-pages for `git log master -1 --pretty=short --abbrev-commit`" && git push deploy HEAD:gh-pages
else
  echo "Sphinx build failed. gh-pages not altered."
fi
