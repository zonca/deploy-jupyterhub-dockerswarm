#!/bin/bash
XFS_ROOT=$1
CREATED_FOLDER=$1/$2
QUOTA=1g
if [[ -d $CREATED_FOLDER ]]; then # check it is a folder
    LAST_PROJECT_ID=$(cut -d":" -f1 /etc/projid | sort -nr | head -1)
    PROJECT_ID=$(($LAST_PROJECT_ID + 1))
    echo $PROJECT_ID:$CREATED_FOLDER >> /etc/projects
    PROJECT_NAME=$(cat ${CREATED_FOLDER}_email.txt)
    echo $PROJECT_NAME:$PROJECT_ID >> /etc/projid
    xfs_quota -x -c "project -s $PROJECT_NAME" $XFS_ROOT
    xfs_quota -x -c "limit -p bhard=$QUOTA $PROJECT_NAME" $XFS_ROOT
    rm ${CREATED_FOLDER}_QUOTA_NOT_SET
    echo "Set quota of $QUOTA to user $PROJECT_NAME on folder $CREATED_FOLDER"
fi
