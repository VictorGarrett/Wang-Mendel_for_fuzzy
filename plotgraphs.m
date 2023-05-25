figure(1)
opt = gensurfOptions
opt.NumGridPoints = 40
opt.InputIndex = [1, 2]
gensurf(fis_best, opt)

figure(2)
opt = gensurfOptions
opt.NumGridPoints = 40
opt.InputIndex = [1, 3]
gensurf(fis_best, opt)

figure(3)
opt = gensurfOptions
opt.NumGridPoints = 40
opt.InputIndex = [2, 3]
gensurf(fis_best, opt)