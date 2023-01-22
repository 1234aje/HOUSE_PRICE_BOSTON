import pickle
import json
import config
import numpy as np

class HousePrice():
    def __init__(self,CRIM, ZN, INDUS, CHAS, NOX, RM, AGE, DIS, RAD, TAX,PTRATIO, B, LSTAT):
        self.CRIM    = CRIM
        self.ZN      = ZN
        self.INDUS   = INDUS
        self.CHAS    = CHAS
        self.NOX     = NOX
        self.RM      = RM
        self.DIS     = DIS
        self.RAD     = RAD
        self.TAX     = TAX
        self.PTRATIO = PTRATIO
        self.B       = B
        self.LSTAT   = LSTAT
    def models(self):
        with open(config.column_path,"r") as f:
            self.column_name = json.load(f)
        with open(config.model_path,"rb") as f:
            self.knn =  pickle.load(f)
        with open(config.scal_path,"rb") as f:
            self.scale = pickle.load(f)
        
    def prediction(self):
        self.models()
        test_array = np.zeros(len(self.column_name["columns"]))
        test_array[0] = self.CRIM 
        test_array[1] = self.ZN    
        test_array[2] = self.INDUS  
        test_array[3] = self.CHAS
        test_array[4] = self.NOX   
        test_array[5] = self.RM 
        test_array[6] = self.DIS
        test_array[7] = self.RAD 
        test_array[8] = self.TAX 
        test_array[9] = self.PTRATIO
        test_array[10] = self.B 
        test_array[11] = self.LSTAT

        scl = self.scale.transform([test_array])

        price = self.knn.predict(scl)
        return price



        