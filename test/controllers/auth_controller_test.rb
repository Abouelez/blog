require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.create!(
      email: "test@email.com",
      name: "test_user",
      password: "password",
      password_confirmation: "password"
    )
  end
  test "should register user with valid data" do
    puts "##############################\nTesting Successful Register"
    post "/register",
    params: {
      name: "Test User",
      email: "exapmle@email.com",
      password: "password",
      password_confirmation: "password"
    }

    assert_response :created
    response_body = JSON.parse(response.body)
    assert response_body["message"].present?
    assert_equal response_body["message"], "User Created Successfully."
    puts "Passed ;)\n##############################"
  end

    test "should not register user with invalid data" do
    puts "##############################\nTesting Failed Register"

    post "/register",
    params: {
      name: "T",
      email: "ex",
      password: "p",
      password_confirmation: "1"
    }

    assert_response :unprocessable_entity
    response_body = JSON.parse(response.body)
    assert response_body["errors"].present?
    puts "Passed ;)\n##############################"
  end

  test "should return token to user" do
    puts "##############################\nTesting Successful Login"
    post "/login",
    params: {
      email: "test@email.com",
      password: "password"
    }
    assert_response :ok
    response_body = JSON.parse(response.body)
    assert response_body["token"].present?
    puts "Passed ;)\n##############################"
  end

    test "should return unauthorized" do
    puts "##############################\nTesting Failed Register"
    post "/login",
    params: {
      email: "test@email.com",
      password: "wrongpassword"
    }
    assert_response :unauthorized
    response_body = JSON.parse(response.body)
    assert response_body["error"].present?
    assert_equal response_body["error"], "Invalid email or password."
    puts "Passed ;)\n##############################"
  end
end
