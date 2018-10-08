#! /bin/bash

MONGO_COMMAND="mongod"
#MONGO_DBPATH="$MONGO_DBPATH"

startMongo(){
        $MONGO_COMMAND --dbpath $MONGO_DBPATH &
        echo "mongo start"
}

initLeanoteData(){
        #if already init do nothing
        if [ ! -e "/data/mongo/LEANOTE_INIT_FLAG" ]; then
                #create inited falg
                mongorestore -h localhost -d leanote --dir $SOFTWARE_ROOT/$LEANOTE_DIR/mongodb_backup/leanote_install_data/
                echo "leanote data init" > $MONGO_DBPATH/LEANOTE_INIT_FLAG
                echo "leanote init data"
        fi
}

startLeanote(){
        $SOFTWARE_ROOT/$LEANOTE_DIR/bin/run.sh &
        echo "leanote started!"
}

main(){
        startMongo
        initLeanoteData
        startLeanote
}

main