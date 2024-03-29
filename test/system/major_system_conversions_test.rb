require "application_system_test_case"

class MajorSystemConversionsTest < ApplicationSystemTestCase
  def setup
    @rich_brain = brains(:rich)
    @public_system = major_systems(:wikipedia_en_original)
  end

  test "conversion redirects to sign in for anonymous brains" do
    visit public_major_systems_path
    find_all("a", text: "Check it out 👀").first.click
    find("a", text: "Memorize 🧠").click
    assert_current_path new_brain_session_path
  end

  test "displays the new major system after brain converts one" do
    login_as @rich_brain

    visit public_major_systems_path
    system_card = find("h5", text: @public_system.origin).sibling(".card-body")
    within system_card do
      click_link "Check it out 👀"
    end

    assert_selector("h1", text: "Major System from #{@public_system.origin}")
    assert_selector(:xpath, "//div[starts-with(@id, 'peg_')]", count: 2)

    find("a", text: "Memorize 🧠").click

    # Check new system shows same data as original.
    assert find("p", text: "Successfully shoved into brain")
    assert find("strong", text: "Origin:").sibling("a", text: @public_system.origin)
    assert find("span", text: "English")
    assert_selector(:xpath, "//div[starts-with(@id, 'peg_')]", count: 2)
    assert_selector(:xpath, "//img[@class='card-img-top']", count: 1)
    @public_system.pegs.each do |peg|
      if peg.image.attached?
        assert_selector(:xpath, "//img[contains(@src, '#{peg.image.filename}')]")
      end
    end
  end

  test "brain sees error when trying to convert a system if limit reached" do
    login_as @rich_brain

    # This reaches the limit given the other major system in fixtures.
    visit public_major_system_url(@public_system)
    find("a", text: "Memorize 🧠").click
    assert find("p", text: "Successfully shoved into brain")

    visit public_major_system_url(@public_system)
    find("a", text: "Memorize 🧠").click
    assert find("p", text: "Your memocortex is full, contact the support if you need more brain space")
    assert_current_path brain_major_systems_path
  end
end
