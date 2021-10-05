import json

file_path = '../../data/business/yelp_academic_dataset_business.json'

with open(file_path, encoding="utf8") as file_data:
    record_list = json.load(file_data.read().replace('\n', ''))

print(record_list)
