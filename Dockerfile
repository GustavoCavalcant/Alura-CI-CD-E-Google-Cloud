# Etapa 1: Usar uma imagem base oficial e leve do Python
# Usar a versão 'slim' economiza espaço em disco.
FROM python:3.13.5-alpine3.22

# Etapa 2: Definir o diretório de trabalho dentro do contêiner
# Todos os comandos subsequentes serão executados a partir deste diretório.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências
# Copiamos primeiro o requirements.txt para aproveitar o cache de camadas do Docker.
# Se este arquivo não mudar, o Docker reutilizará a camada de instalação das dependências.
COPY requirements.txt .

# Etapa 4: Instalar as dependências
# --no-cache-dir: Desabilita o cache do pip, reduzindo o tamanho da imagem.
# -r requirements.txt: Instala os pacotes listados no arquivo.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o código da aplicação para o diretório de trabalho
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada
# O Uvicorn, por padrão, roda na porta 8000.
EXPOSE 8000

# Etapa 7: Definir o comando para iniciar a aplicação quando o contêiner for executado
# uvicorn app:app: Executa a instância 'app' do arquivo 'app.py'.
# --host 0.0.0.0: Torna a aplicação acessível de fora do contêiner.
# --port 8000: Especifica a porta.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]