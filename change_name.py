import os
replacement = "nakshekadam_web"
for dname, dirs, files in os.walk("./lib"):
    for fname in files:
        fpath = os.path.join(dname, fname)
        print(fpath)
        with open(fpath,"r") as f:
            s = f.read()
        s = s.replace("nakshekadam", replacement)
        with open(fpath, "w") as f:
            f.write(s)