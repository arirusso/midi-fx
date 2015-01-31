require "helper"

class MIDIFX::FilterTest < Minitest::Test

  def test_high_pass_note_reject
    message = MIDIMessage::NoteOn["C0"].new(0, 100)
    assert_equal(12, message.note)
    output = MIDIFX::HighPassFilter.new(:note, 20).process(message)
    assert_equal(nil, output)
  end

  def test_high_pass_note_accept
    message = MIDIMessage::NoteOn["C4"].new(0, 100)
    assert_equal(60, message.note)
    output = MIDIFX::HighPassFilter.new(:note, 20).process(message)
    assert_equal(message, output)
  end

  def test_low_pass_note_reject
    message = MIDIMessage::NoteOn["C4"].new(0, 100)
    assert_equal(60, message.note)
    output = MIDIFX::LowPassFilter.new(:note, 50).process(message)
    assert_equal(nil, output)
  end

  def test_low_pass_note_accept
    message = MIDIMessage::NoteOn["C4"].new(0, 100)
    assert_equal(60, message.note)
    output = MIDIFX::LowPassFilter.new(:note, 100).process(message)
    assert_equal(message, output)
  end

  def test_band_pass_note_reject
    message = MIDIMessage::NoteOn["C4"].new(0, 100)
    assert_equal(60, message.note)
    output = MIDIFX::BandPassFilter.new(:note, (20..50)).process(message)
    assert_equal(nil, output)
  end

  def test_band_pass_note_accept
    message = MIDIMessage::NoteOn["C4"].new(0, 100)
    assert_equal(60, message.note)
    output = MIDIFX::BandPassFilter.new(:note, (20..100)).process(message)
    assert_equal(message, output)
  end

  def test_band_reject_note_reject
    message = MIDIMessage::NoteOn["C4"].new(0, 100)
    assert_equal(60, message.note)
    output = MIDIFX::NotchFilter.new(:note, (20..70)).process(message)
    assert_equal(nil, output)
  end

  def test_band_reject_note_accept
    message = MIDIMessage::NoteOn["C4"].new(0, 100)
    assert_equal(60, message.note)
    output = MIDIFX::NotchFilter.new(:note, (20..50)).process(message)
    assert_equal(message, output)
  end

  def test_multiband_note_reject
    message = MIDIMessage::NoteOn["C4"].new(0, 100)
    assert_equal(60, message.note)
    output = MIDIFX::Filter.new(:note, [(20..30), (40..50)]).process(message)
    assert_equal(nil, output)
  end

  def test_multiband_note_accept
    message = MIDIMessage::NoteOn["C4"].new(0, 100)
    assert_equal(60, message.note)
    output = MIDIFX::Filter.new(:note, [(20..30), (50..70)]).process(message)
    assert_equal(message, output)
  end

  def test_multinotch_note_reject
    message = MIDIMessage::NoteOn["C4"].new(0, 100)
    assert_equal(60, message.note)
    output = MIDIFX::Filter.new(:note, [(20..30), (55..65)], :reject => true).process(message)
    assert_equal(nil, output)
  end

  def test_multinotch_note_accept
    message = MIDIMessage::NoteOn["C4"].new(0, 100)
    assert_equal(60, message.note)
    output = MIDIFX::Filter.new(:note, [(20..30), (40..50)], :reject => true).process(message)
    assert_equal(message, output)
  end

  def test_numeric_note_accept
    message1 = MIDIMessage::NoteOn["C4"].new(0, 100)
    message2 = MIDIMessage::NoteOn["C5"].new(0, 100)
    f = MIDIFX::Filter.new(:note, 60)
    output = f.process(message1)
    assert_equal(message1, output)
    output = f.process(message2)
    assert_equal(nil, output)
  end

  def test_numeric_note_reject
    message1 = MIDIMessage::NoteOn["C4"].new(0, 100)
    message2 = MIDIMessage::NoteOn["C5"].new(0, 100)
    f = MIDIFX::Filter.new(:note, 60, :reject => true)
    output = f.process(message1)
    assert_equal(nil, output)
    output = f.process(message2)
    assert_equal(message2, output)
  end

end
