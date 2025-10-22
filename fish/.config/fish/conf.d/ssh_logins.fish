function cit-login-port-forward
    ssh -i ~/.ssh/id_rsa_ligo -L 5005:localhost:5005 $argv[1]@ldas-pcdev$argv[2].ligo.caltech.edu
end

function cit-login
    ssh -i ~/.ssh/id_rsa_ligo $argv[1]@ldas-pcdev$argv[2].ligo.caltech.edu
end

function llo-login
    ssh -i ~/.ssh/id_rsa_ligo $argv[1]@ldas-pcdev$argv[2].ligo-la.caltech.edu
end

function lho-login
    ssh -i ~/.ssh/id_rsa_ligo $argv[1]@ldas-pcdev$argv[2].ligo-wa.caltech.edu
end

function osg-login
    ssh -i ~/.ssh/id_rsa_ligo $argv[1]@ldas-osg2.ligo.caltech.edu
end

function lho-login-port-forward
    ssh -i ~/.ssh/id_rsa_ligo -L 5005:localhost:5005 $argv[1]@ldas-pcdev$argv[2].ligo-wa.caltech.edu
end

function olib-login
    ssh -i ~/.ssh/id_rsa_ligo $argv[1]@olib.ligo.caltech.edu
end

function aframe-login
    ssh -A -i ~/.ssh/id_rsa_ligo ethan.marx@ldas-grid.ligo.caltech.edu
end

function olib-login-port-forward
    ssh -i ~/.ssh/id_rsa_ligo -L 5005:localhost:5005 $argv[1]@olib.ligo.caltech.edu
end

function vizapp-login-port-forward
    ssh -i ~/.ssh/id_rsa_ligo -L 5005:localhost:5005 $argv[1]@ligo-olib.mit.edu
end

function delta-login
    ssh emarx@dt-login0$argv[1].delta.ncsa.illinois.edu
end
