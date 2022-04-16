 # -*- coding: utf-8 -*-
def zfill(value, width):
  """
  Zfill filter for ansible
  """
  return value.zfill(width)

class FilterModule(object):
  """Filter module"""

  def filters(self):
    return {
      'zfill': zfill
    }