@echo off
cd /d C:\src\allapp\appr

echo Adding all files in lib...
git add lib

echo Committing changes...
git commit -m "رفع كل ملفات lib"

echo Pushing to GitHub...
git push

echo Done! ✅
pause
