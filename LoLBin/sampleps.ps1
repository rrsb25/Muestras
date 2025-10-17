write-host "Howdy!!!"
FILE_TO_WRITE = "simple_output.txt"
DATA_CONTENT = "This is a simple text document created by the Python script."

# 2. Execution: Write the content to the file
try:
    # 'w' mode: opens for writing, creates file if it doesn't exist, overwrites if it does.
    # The 'with' block ensures the file is closed automatically.
    with open(FILE_TO_WRITE, 'w') as f:
        f.write(DATA_CONTENT)
    
    print(f"File created successfully: '{FILE_TO_WRITE}'")
    print(f"Content: {DATA_CONTENT}")

except Exception as e:
    print(f"An error occurred while writing the file: {e}")
