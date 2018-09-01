# MachineLearning-A-Z-Udemy
## Run Jupyter:
jupyter notebook --ip=0.0.0.0 --port=8080 --no-browser  
ou  
./launch_jupyter.sh  
fazer preview, abrir no browser e por o token  

## push to git
git add README.md  
git add .   #se quiser adicionar todos os files dessa folder  
git add -u :/ adds all modified file changes to the stage  
  
git status  
  
git commit -m "first commit"  
  
git remote add origin https://github.com/nleitao/Udemy.MachineLearning.git  
git push -u origin master  


## Remove file from to be commited list:  
git reset 'file_name'

## Se tiver ficheiros que quiser remover do tracked/untracked. Pergunta um a um o que quero fazer  
git clean -i -fd  

#When I commit changes to git from other source and want to bring this source up to date:
git pull
