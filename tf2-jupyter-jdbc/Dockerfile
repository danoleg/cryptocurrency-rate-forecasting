FROM tensorflow/tensorflow:2.2.0-jupyter

RUN apt-get update && apt-get install gcc && \
 apt-get install -y tdsodbc unixodbc-dev && \
 apt install unixodbc-bin -y && \
 apt-get install -y default-jre-headless && \
 apt-get clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

RUN rm /etc/odbcinst.ini && \
    rm /etc/odbc.ini && \
    ln -s /tf/odbcinst.ini /etc/odbcinst.ini && \
    ln -s /tf/odbc.ini /etc/odbc


CMD /bin/bash -c "source /etc/bash.bashrc && jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token=''"