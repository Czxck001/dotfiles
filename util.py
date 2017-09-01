#!/usr/bin/python
import os.path as op
import shutil
import fire

_home = op.expanduser('~')
_root = op.dirname(op.abspath(__file__))
_vimrc_u = op.join(_home, '.vimrc')
_vimrc_l = op.join(_root, 'vimrc')


class Main:
    def push(self, util):
        if util == 'vim':
            shutil.copyfile(_vimrc_l, _vimrc_u)

    def pull(self, util):
        if util == 'vim':
            shutil.copyfile(_vimrc_u, _vimrc_l)


if __name__ == '__main__':
    fire.Fire(Main)
