# DevOps. Задачи от Радиочастотных систем

## 1. Linux-команды
  ```bash
  sudo, mkdir, touch, chmod, cp, mv, ls, cat, tee, grep, echo, docker build, docker run
  ```

## 2. Напишите команду в Linux, которая будет:
  - Будет печатать строку "Hello, DevOps!".
  - Записывать ее в файл hello.txt в домашней директории.
  - Выводить содержимое файла на экран.
  ```bash
  echo Hello, DevOps!
  echo "Hello, DevOps\!" > hello.txt
  cat hello.txt
  ```
  Или
  ```bash
  echo "Hello, DevOps\!" | tee hello.txt && cat hello.txt
  ```
  ![image](https://github.com/user-attachments/assets/4280f81d-5f9a-4b29-a7db-4fb9e939bb4b)

## 3. Напишите команду в Linux, которая будет:
  - Читать /var/log/syslog (или любой другой лог или файл).
  - Искать строки с "error" или любым другим словом.
  - Выводить 5 первых совпавших с шаблоном строк.
  Это нужно сделать одной командой, используя конвейеры (pipes).
  ```bash
  journalctl | grep "error" | head -n5
  ```
  ![image](https://github.com/user-attachments/assets/793930ec-5013-4dc4-84ab-e3f0fab1d87f)

## 4. Bash/python скрипт. 
  - Необходимо создать файл, записать туда набор входных строк и написать скрипт на bash или python, который будет искать в этом файле конкретные слова (например, path)  и выводить найденные строки

  ### config.txt:
  ```      
  name: test_server
  path: /home/user/data
  file: data.txt
  port: 8080
  log path: /var/log/app
  ```

  ### Bash скрипт:
  ```bash
  #!/bin/bash
  if [ $# -lt 2 ]; then
          echo "Usage: $0 <file> <word>"
          exit 1
  fi
  grep "$2" "$1"

  ```
  ![image](https://github.com/user-attachments/assets/fd4acb7c-d8a8-43b0-9285-213885ff8793)
  
  ### Python скрипт:
  ```python
  #!/usr/bin/env python3
  import sys
  import re
  
  if len(sys.argv) != 3:
      print(f"Usage: {sys.argv[0]} <file> <word>")
      sys.exit(1)
  
  file, word = sys.argv[1], sys.argv[2]
  
  try:
      with open(file, 'r') as f:
          for line in f:
              if re.search(word, line):
                  print(line.strip())
  except FileNotFoundError:
      sys.exit(f"File '{file}' not found.")
  ```
  ![image](https://github.com/user-attachments/assets/9a8b3e5a-f571-475a-b7d7-a05c806a213f)

## 5. Оптимизируйте следующий Dockerfile, в котором прописан запуск скриптов из предыдущего пункта
  ```Dockerfile
  FROM ubuntu:latest
  RUN apt-get update
  RUN apt-get install -y wget
  RUN apt-get install -y python3
  RUN apt-get install -y python3-pip
  COPY search_path.sh /tmp/search_path.sh
  COPY search_path.sh /tmp/extract_path_value.py
  COPY config.txt /tmp/config.txt
  RUN chmod +x /tmp/search_path.sh
  RUN chmod +x /tmp/extract_path_value.py
  ```
  Оптимизированный Dockerfile:
  - Образ поменьше python:3.11-slim (сразу есть python3, python3-pip)
  - Не устанавливаю ненужные пакеты --no-install-recommends
  - Одной командой копирую файлы
  - Одной командой отдаю права на исполнение
  ```Dockerfile
  FROM python:3.11-slim

  RUN apt-get update \
      && apt-get install -y --no-install-recommends wget
  
  COPY search_path.sh extract_path_value.py config.txt /tmp/
  
  RUN chmod +x /tmp/search_path.sh /tmp/extract_path_value.py
  ```
  ![image](https://github.com/user-attachments/assets/6e649666-d5d6-4f6f-bdbc-d6473f3eeeeb)
