# -*- coding: utf-8 -*-
import sys, os

from flask import Flask, jsonify, request
app = Flask(__name__)

@app.route('/service', methods=['GET'])
def service():
    return "Welcome to the flask service world!!"

def test():
    app.run(debug=True)

if __name__ == '__main__':
    test()
