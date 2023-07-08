import sys
import json
from langchain.document_loaders import TextLoader
from langchain.vector_indexes import VectorestoreIndexCreator

query = sys.stdin.readline().strip()

loader = TextLoader('../study_data.txt')
index = VectorestoreIndexCreator().from_loaders([loader])

result = index.query(query)

sys.stdout.write(json.dumps(result))