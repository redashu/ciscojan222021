from flask import Flask 
app = Flask(__name__) 

@app.route('/') 
def hello(): 
	return "welcome to the flask tutorials in Cisco Training !!"

def cisco(): 
	return "THis is my version 2 of app !!"


# Flask has its own web server that runs on 5000 port
if __name__ == "__main__": 
	app.run(host ='0.0.0.0', port = 5000, debug = True) 

