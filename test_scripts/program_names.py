
import sys
import json

if __name__ == "__main__":

    json_file = open(sys.argv[1], "r")
    json_data = json.load(json_file)
    print len(json_data["CVE_Items"])

    CVE_items = json_data["CVE_Items"]
    
    for i in range(len(CVE_items)):
        if len(CVE_items[i]["cve"]["affects"]["vendor"]["vendor_data"]) > 0:
            print CVE_items[i]["cve"]["affects"]["vendor"]["vendor_data"][0]["product"]["product_data"][0]["product_name"]
