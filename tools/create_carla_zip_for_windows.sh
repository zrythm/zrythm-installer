#! /bin/bash

commit=$1
inner_dir=Carla-$commit

pushd /tmp
wget https://github.com/falkTX/Carla/archive/$commit.zip
unzip $commit.zip
rm $inner_dir/bin/carla.lv2/resources
mv $inner_dir $inner_dir.old
cp -rL $inner_dir.old $inner_dir
tar cfz $inner_dir.tar.gz $inner_dir
rsync -av $inner_dir.tar.gz $RSYNC_USER@$RSYNC_PATH
popd
