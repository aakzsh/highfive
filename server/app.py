from flask import Flask, render_template, request, jsonify
from werkzeug.utils import secure_filename
import json
from datetime import datetime
import os

app = Flask(__name__)

app.config["UPLOAD_FOLDER"] = "static/"

@app.route('/')
def upload_file():
    return render_template('index.html')


@app.route('/display', methods = ['GET', 'POST'])
def save_file():
    if request.method == 'POST':
        f = request.files['file']
        filename = secure_filename(f.filename)
        f.save(app.config['UPLOAD_FOLDER'] + filename)
        file = open(app.config['UPLOAD_FOLDER'] + filename,"r")
        # content = file.read()   
    return render_template('content.html', content=file.name) 


@app.route('/chats')
def chats():
    filepath = 'static/messages.json'
    # Load the JSON data from the file
    with open(filepath) as f:
        data = json.load(f)
    # Return the JSON data using jsonify
    return jsonify(data)


@app.route('/addmessage/<newtext>/<author>')
def addmessage(newtext, author):
    filepath = 'static/messages.json'
    now = datetime.now()
    newstr =  f"Today at {now.strftime('%H:%M')}"
    # Load the JSON data from the file
    with open(filepath) as f:
        data = json.load(f)
    data["texts"].append({"content": newtext, "datetime": newstr, "author": author})
    with open(filepath, 'w') as f:
        json.dump(data, f, indent=4)
    # Return the JSON data using jsonify
    return jsonify(data)


@app.route('/announcements')
def announcements():
    filepath = 'static/announcements.json'
    # Load the JSON data from the file
    with open(filepath) as f:
        data = json.load(f)
    # Return the JSON data using jsonify
    return jsonify(data)


@app.route('/addannouncement/<newtext>')
def addannouncement(newtext):
    filepath = 'static/announcements.json'
    now = datetime.now()
    newstr =  f"{now.strftime('%H:%M')}"
    # Load the JSON data from the file
    with open(filepath) as f:
        data = json.load(f)
    data["announcements"].append({"content": newtext, "datetime": newstr})
    with open(filepath, 'w') as f:
        json.dump(data, f, indent=4)

    # Return the JSON data using jsonify
    return jsonify(data)


@app.route('/getfiles')
def getfiles():
    files = [f for f in os.listdir("static") if os.path.isfile(os.path.join("static", f))]
    files.remove("announcements.json")
    files.remove("messages.json")
    files.remove("dummy.txt")
    return  files


@app.route('/uploadfile', methods=["POST"])
def uploadfile():
    try:
        if request.method == 'POST':
            f = request.files['file']
            filename = secure_filename(f.filename)

            f.save(app.config['UPLOAD_FOLDER'] + filename)

            file = open(app.config['UPLOAD_FOLDER'] + filename,"r")
            # content = file.read()
        return jsonify({"success": True})
    except:
        return jsonify({"success": False})
    

@app.route('/clearall')
def clearall():
    try:
        filepath = 'static/announcements.json'
        with open(filepath, 'w') as f:
            json.dump({"announcements": []}, f, indent=4)
        filepath = 'static/messages.json'
        with open(filepath, 'w') as f:
            json.dump({"texts": []}, f, indent=4)
        files = [f for f in os.listdir("static") if os.path.isfile(os.path.join("static", f))]
        files.remove("announcements.json")
        files.remove("messages.json")
        files.remove("dummy.txt")
        for file in files:
            os.remove("static/"+file)
        return  jsonify({"success": True})
    except:
        return  jsonify({"success": False})


if __name__ == '__main__':
    app.run( host="0.0.0.0",port=5000, debug = True)
    # it is actually running on 192.168.4.1:5000 on the raspberry pi