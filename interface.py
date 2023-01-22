from flask import Flask,jsonify,render_template,request
from PROJECT.utils import HousePrice
import numpy as np

app = Flask(__name__)
@app.route("/")
def evening_batch():
    return "testing api"

@app.route("/price",methods = ["GET"])
def price_prediction():
    value = request.form
    CRIM     =  eval(value["CRIM"])
    ZN       =  eval(value["ZN"])
    INDUS    =  eval(value["INDUS"])
    CHAS     =  eval(value["CHAS"])
    NOX      =  eval(value["NOX"])
    RM       =  eval(value["RM"])
    AGE      =  eval(value["AGE"])
    DIS      =  eval(value["DIS"])
    RAD      =  eval(value["RAD"])
    TAX      =  eval(value["TAX"])
    PTRATIO  =  eval(value["PTRATIO"])
    B        =  eval(value["B"])
    LSTAT    =  eval(value["LSTAT"])

    house_p = HousePrice(CRIM,ZN,INDUS,CHAS,NOX,RM,AGE,DIS,RAD,TAX,PTRATIO,B,LSTAT)
    pr = house_p.prediction()
    return jsonify({"result": f"The house price of boston is {np.around(pr[0],2)} lakhs "})

    




if __name__== "__main__":
    app.run()
