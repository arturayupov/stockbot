FROM python:3.7-alpine

COPY requirements.txt /
RUN pip install -r /requirements.txt

RUN echo '0 12 * * * source /.env; /send_stock_update.py "$STOCK_SYMBOL" "$TG_CHAT"' | crontab -

COPY send_stock_update.py /

CMD env > /.env; crond -f -L /dev/stdout
