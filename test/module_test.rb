require "helper"

class MIDIFX::ModuleTest < Test::Unit::TestCase

  def test_class_method
    msg = MIDIMessage::NoteOn["C4"].new(0, 100)
    assert_equal(60, msg.note)
    MIDIFX.transpose(msg, :note, 5)
    assert_equal(65, msg.note)
  end


end
