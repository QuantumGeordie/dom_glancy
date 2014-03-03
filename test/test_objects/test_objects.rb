module Kracker
  module TestObjects
    def array_of_elements
      [
        {"id"=>"1", "height"=>238, "visible"=>true, "tag"=>"DIV", "width"=>720, "class"=>"grid", "left"=>43, "top"=>14},
        {"id"=>"2", "height"=>132, "visible"=>true, "tag"=>"DIV", "width"=>700, "class"=>"row", "left"=>53, "top"=>14},
        {"id"=>"3", "height"=>132, "visible"=>true, "tag"=>"DIV", "width"=>340, "class"=>"slot-0-1-2 mm--title_text_main", "left"=>53, "top"=>14},
        {"id"=>"4", "height"=>132, "visible"=>true, "tag"=>"H1", "width"=>340, "class"=>"", "left"=>53, "top"=>14},
        {"id"=>"5", "height"=>0, "visible"=>true, "tag"=>"SPAN", "width"=>0, "class"=>"mm--title_text_sub", "left"=>71, "top"=>86},
        {"id"=>"6", "height"=>55, "visible"=>true, "tag"=>"DIV", "width"=>700, "class"=>"row", "left"=>53, "top"=>160},
        {"id"=>"7", "height"=>55, "visible"=>true, "tag"=>"DIV", "width"=>340, "class"=>"slot-0-1-2", "left"=>53, "top"=>160},
        {"id"=>"8", "height"=>55, "visible"=>true, "tag"=>"H2", "width"=>340, "class"=>"", "left"=>53, "top"=>160},
        {"id"=>"9", "height"=>23, "visible"=>true, "tag"=>"DIV", "width"=>700, "class"=>"row", "left"=>53, "top"=>229},
        {"id"=>"10", "height"=>21, "visible"=>true, "tag"=>"DIV", "width"=>100, "class"=>"slot-0 mm--nav", "left"=>53, "top"=>231},
        {"id"=>"11", "height"=>21, "visible"=>true, "tag"=>"DIV", "width"=>100, "class"=>"slot-1 mm--nav", "left"=>173, "top"=>231}
      ]
    end

    def array_of_elements_small
      [
          {"id"=>"12", "height"=>238, "visible"=>true, "tag"=>"DIV", "width"=>720, "class"=>"grid", "left"=>43, "top"=>14},
          {"id"=>"14", "height"=>0, "visible"=>true, "tag"=>"SPAN", "width"=>0, "class"=>"mm--title_text_sub", "left"=>71, "top"=>86}
      ]
    end

    def single_element_hash
      {"id"=>"mm--single_added", "height"=>10, "visible"=>true, "tag"=>"SPAN", "width"=>50, "class"=>"mm--title_text_sub", "left"=>71, "top"=>86}
    end

    def travis_generated_current_2
      data = <<-DATA
---
- height: 45
  width: 784
  id: ''
  tag: DIV
  class: contain-to-grid fixed
  top: 0
  left: 0
  visible: true
- height: 45
  width: 784
  id: ''
  tag: NAV
  class: top-bar
  top: 0
  left: 0
  visible: true
- height: 45
  width: 140
  id: ''
  tag: UL
  class: title-area
  top: 0
  left: 0
  visible: true
- height: 45
  width: 140
  id: ''
  tag: LI
  class: name
  top: 0
  left: 0
  visible: true
- height: 45
  width: 140
  id: ''
  tag: H1
  class: ''
  top: 0
  left: 0
  visible: true
- height: 45
  width: 140
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: true
- height: 0
  width: 0
  id: ''
  tag: LI
  class: toggle-topbar menu-icon
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 784
  id: ''
  tag: SECTION
  class: top-bar-section
  top: 0
  left: 0
  visible: true
- height: 45
  width: 504
  id: ''
  tag: UL
  class: right
  top: 0
  left: 280
  visible: true
- height: 45
  width: 86
  id: ''
  tag: LI
  class: active
  top: 0
  left: 280
  visible: true
- height: 45
  width: 86
  id: ''
  tag: A
  class: ''
  top: 0
  left: 280
  visible: true
- height: 45
  width: 94
  id: ''
  tag: LI
  class: active
  top: 0
  left: 366
  visible: true
- height: 45
  width: 94
  id: ''
  tag: A
  class: ''
  top: 0
  left: 366
  visible: true
- height: 45
  width: 70
  id: ''
  tag: LI
  class: active
  top: 0
  left: 460
  visible: true
- height: 45
  width: 70
  id: ''
  tag: A
  class: ''
  top: 0
  left: 460
  visible: true
- height: 45
  width: 78
  id: ''
  tag: LI
  class: active
  top: 0
  left: 530
  visible: true
- height: 45
  width: 78
  id: ''
  tag: A
  class: ''
  top: 0
  left: 530
  visible: true
- height: 45
  width: 78
  id: ''
  tag: LI
  class: active
  top: 0
  left: 608
  visible: true
- height: 45
  width: 78
  id: ''
  tag: A
  class: ''
  top: 0
  left: 608
  visible: true
- height: 45
  width: 98
  id: ''
  tag: LI
  class: has-dropdown not-click
  top: 0
  left: 686
  visible: true
- height: 45
  width: 98
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: true
- height: 0
  width: 0
  id: ''
  tag: UL
  class: dropdown
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: title back js-generated
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: H5
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 20
  width: 784
  id: ''
  tag: DIV
  class: row
  top: 45
  left: 0
  visible: true
- height: 20
  width: 784
  id: ''
  tag: DIV
  class: large-3 columns
  top: 45
  left: 0
  visible: true
- height: 0
  width: 754
  id: ''
  tag: P
  class: notice
  top: 0
  left: 15
  visible: true
- height: 0
  width: 754
  id: ''
  tag: P
  class: alert
  top: 20
  left: 15
  visible: true
- height: 0
  width: 784
  id: ''
  tag: DIV
  class: large-9 columns
  top: 65
  left: 0
  visible: true
- height: 504
  width: 784
  id: ''
  tag: DIV
  class: row
  top: 65
  left: 0
  visible: true
- height: 504
  width: 784
  id: ''
  tag: DIV
  class: large-12 columns
  top: 65
  left: 0
  visible: true
- height: 52
  width: 754
  id: ''
  tag: H2
  class: ''
  top: 3
  left: 15
  visible: true
- height: 409
  width: 754
  id: new_user
  tag: FORM
  class: new_user
  top: 63
  left: 15
  visible: true
- height: 0
  width: 0
  id: ''
  tag: DIV
  class: ''
  top: 48
  left: 15
  visible: true
- height: 0
  width: 0
  id: ''
  tag: INPUT
  class: ''
  top: 0
  left: 0
  visible: false
- height: 93
  width: 754
  id: ''
  tag: P
  class: ''
  top: 63
  left: 15
  visible: true
- height: 22
  width: 754
  id: ''
  tag: LABEL
  class: ''
  top: 63
  left: 15
  visible: true
- height: 26
  width: 0
  id: ''
  tag: BR
  class: ''
  top: 93
  left: 15
  visible: true
- height: 35
  width: 752
  id: user_name
  tag: INPUT
  class: ''
  top: 119
  left: 15
  visible: true
- height: 75
  width: 754
  id: ''
  tag: DIV
  class: ''
  top: 176
  left: 15
  visible: true
- height: 14
  width: 754
  id: ''
  tag: LABEL
  class: ''
  top: 176
  left: 15
  visible: true
- height: 16
  width: 0
  id: ''
  tag: BR
  class: ''
  top: 198
  left: 15
  visible: true
- height: 35
  width: 752
  id: user_email
  tag: INPUT
  class: ''
  top: 214
  left: 15
  visible: true
- height: 75
  width: 754
  id: ''
  tag: DIV
  class: ''
  top: 267
  left: 15
  visible: true
- height: 14
  width: 754
  id: ''
  tag: LABEL
  class: ''
  top: 267
  left: 15
  visible: true
- height: 16
  width: 0
  id: ''
  tag: BR
  class: ''
  top: 289
  left: 15
  visible: true
- height: 35
  width: 752
  id: user_password
  tag: INPUT
  class: ''
  top: 305
  left: 15
  visible: true
- height: 75
  width: 754
  id: ''
  tag: DIV
  class: ''
  top: 358
  left: 15
  visible: true
- height: 14
  width: 754
  id: ''
  tag: LABEL
  class: ''
  top: 358
  left: 15
  visible: true
- height: 16
  width: 0
  id: ''
  tag: BR
  class: ''
  top: 380
  left: 15
  visible: true
- height: 35
  width: 752
  id: user_password_confirmation
  tag: INPUT
  class: ''
  top: 396
  left: 15
  visible: true
- height: 23
  width: 754
  id: ''
  tag: DIV
  class: ''
  top: 449
  left: 15
  visible: true
- height: 19
  width: 71
  id: ''
  tag: INPUT
  class: ''
  top: 449
  left: 15
  visible: true
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 471
  left: 15
  visible: true
- height: 16
  width: 0
  id: ''
  tag: BR
  class: ''
  top: 472
  left: 85
  visible: true
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 487
  left: 15
  visible: true
- height: 16
  width: 0
  id: ''
  tag: BR
  class: ''
  top: 488
  left: 225
  visible: true
- height: 0
  width: 0
  id: ''
  tag: SCRIPT
  class: ''
  top: 0
  left: 0
  visible: false

      DATA

      YAML::load(data)
    end

    def travis_local_generated_master_2
      data = <<-DATA
---
- height: 45
  width: 785
  id: ''
  tag: DIV
  class: contain-to-grid fixed
  top: 0
  left: 0
  visible: true
- height: 45
  width: 785
  id: ''
  tag: NAV
  class: top-bar
  top: 0
  left: 0
  visible: true
- height: 45
  width: 143
  id: ''
  tag: UL
  class: title-area
  top: 0
  left: 0
  visible: true
- height: 45
  width: 143
  id: ''
  tag: LI
  class: name
  top: 0
  left: 0
  visible: true
- height: 45
  width: 143
  id: ''
  tag: H1
  class: ''
  top: 0
  left: 0
  visible: true
- height: 45
  width: 143
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: true
- height: 0
  width: 0
  id: ''
  tag: LI
  class: toggle-topbar menu-icon
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 785
  id: ''
  tag: SECTION
  class: top-bar-section
  top: 0
  left: 0
  visible: true
- height: 45
  width: 497
  id: ''
  tag: UL
  class: right
  top: 0
  left: 288
  visible: true
- height: 45
  width: 85
  id: ''
  tag: LI
  class: active
  top: 0
  left: 288
  visible: true
- height: 45
  width: 85
  id: ''
  tag: A
  class: ''
  top: 0
  left: 288
  visible: true
- height: 45
  width: 93
  id: ''
  tag: LI
  class: active
  top: 0
  left: 373
  visible: true
- height: 45
  width: 93
  id: ''
  tag: A
  class: ''
  top: 0
  left: 373
  visible: true
- height: 45
  width: 69
  id: ''
  tag: LI
  class: active
  top: 0
  left: 465
  visible: true
- height: 45
  width: 69
  id: ''
  tag: A
  class: ''
  top: 0
  left: 465
  visible: true
- height: 45
  width: 77
  id: ''
  tag: LI
  class: active
  top: 0
  left: 534
  visible: true
- height: 45
  width: 77
  id: ''
  tag: A
  class: ''
  top: 0
  left: 534
  visible: true
- height: 45
  width: 77
  id: ''
  tag: LI
  class: active
  top: 0
  left: 611
  visible: true
- height: 45
  width: 77
  id: ''
  tag: A
  class: ''
  top: 0
  left: 611
  visible: true
- height: 45
  width: 97
  id: ''
  tag: LI
  class: has-dropdown not-click
  top: 0
  left: 688
  visible: true
- height: 45
  width: 97
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: true
- height: 0
  width: 0
  id: ''
  tag: UL
  class: dropdown
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: title back js-generated
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: H5
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 20
  width: 785
  id: ''
  tag: DIV
  class: row
  top: 45
  left: 0
  visible: true
- height: 20
  width: 785
  id: ''
  tag: DIV
  class: large-3 columns
  top: 45
  left: 0
  visible: true
- height: 0
  width: 755
  id: ''
  tag: P
  class: notice
  top: 0
  left: 15
  visible: true
- height: 0
  width: 755
  id: ''
  tag: P
  class: alert
  top: 20
  left: 15
  visible: true
- height: 0
  width: 785
  id: ''
  tag: DIV
  class: large-9 columns
  top: 65
  left: 0
  visible: true
- height: 502
  width: 785
  id: ''
  tag: DIV
  class: row
  top: 65
  left: 0
  visible: true
- height: 502
  width: 785
  id: ''
  tag: DIV
  class: large-12 columns
  top: 65
  left: 0
  visible: true
- height: 52
  width: 755
  id: ''
  tag: H2
  class: ''
  top: 3
  left: 15
  visible: true
- height: 407
  width: 755
  id: new_user
  tag: FORM
  class: new_user
  top: 63
  left: 15
  visible: true
- height: 0
  width: 0
  id: ''
  tag: DIV
  class: ''
  top: 48
  left: 15
  visible: true
- height: 0
  width: 0
  id: ''
  tag: INPUT
  class: ''
  top: 0
  left: 0
  visible: false
- height: 93
  width: 755
  id: ''
  tag: P
  class: ''
  top: 63
  left: 15
  visible: true
- height: 22
  width: 755
  id: ''
  tag: LABEL
  class: ''
  top: 63
  left: 15
  visible: true
- height: 26
  width: 0
  id: ''
  tag: BR
  class: ''
  top: 93
  left: 15
  visible: true
- height: 35
  width: 753
  id: user_name
  tag: INPUT
  class: ''
  top: 119
  left: 15
  visible: true
- height: 75
  width: 755
  id: ''
  tag: DIV
  class: ''
  top: 176
  left: 15
  visible: true
- height: 14
  width: 755
  id: ''
  tag: LABEL
  class: ''
  top: 176
  left: 15
  visible: true
- height: 16
  width: 0
  id: ''
  tag: BR
  class: ''
  top: 198
  left: 15
  visible: true
- height: 35
  width: 753
  id: user_email
  tag: INPUT
  class: ''
  top: 214
  left: 15
  visible: true
- height: 75
  width: 755
  id: ''
  tag: DIV
  class: ''
  top: 267
  left: 15
  visible: true
- height: 14
  width: 755
  id: ''
  tag: LABEL
  class: ''
  top: 267
  left: 15
  visible: true
- height: 16
  width: 0
  id: ''
  tag: BR
  class: ''
  top: 289
  left: 15
  visible: true
- height: 35
  width: 753
  id: user_password
  tag: INPUT
  class: ''
  top: 305
  left: 15
  visible: true
- height: 75
  width: 755
  id: ''
  tag: DIV
  class: ''
  top: 358
  left: 15
  visible: true
- height: 14
  width: 755
  id: ''
  tag: LABEL
  class: ''
  top: 358
  left: 15
  visible: true
- height: 16
  width: 0
  id: ''
  tag: BR
  class: ''
  top: 380
  left: 15
  visible: true
- height: 35
  width: 753
  id: user_password_confirmation
  tag: INPUT
  class: ''
  top: 396
  left: 15
  visible: true
- height: 21
  width: 755
  id: ''
  tag: DIV
  class: ''
  top: 449
  left: 15
  visible: true
- height: 16
  width: 46
  id: ''
  tag: INPUT
  class: ''
  top: 450
  left: 15
  visible: true
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 468
  left: 15
  visible: true
- height: 16
  width: 0
  id: ''
  tag: BR
  class: ''
  top: 470
  left: 82
  visible: true
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 484
  left: 15
  visible: true
- height: 16
  width: 0
  id: ''
  tag: BR
  class: ''
  top: 486
  left: 217
  visible: true
- height: 0
  width: 0
  id: ''
  tag: SCRIPT
  class: ''
  top: 0
  left: 0
  visible: false
      DATA

      YAML::load(data)
    end


    def travis_generated_current
      data = <<-DATA
---
- height: 45
  width: 800
  id: ''
  tag: DIV
  class: contain-to-grid fixed
  top: 0
  left: 0
  visible: true
- height: 45
  width: 800
  id: ''
  tag: NAV
  class: top-bar
  top: 0
  left: 0
  visible: true
- height: 45
  width: 140
  id: ''
  tag: UL
  class: title-area
  top: 0
  left: 0
  visible: true
- height: 45
  width: 140
  id: ''
  tag: LI
  class: name
  top: 0
  left: 0
  visible: true
- height: 45
  width: 140
  id: ''
  tag: H1
  class: ''
  top: 0
  left: 0
  visible: true
- height: 45
  width: 140
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: true
- height: 0
  width: 0
  id: ''
  tag: LI
  class: toggle-topbar menu-icon
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 800
  id: ''
  tag: SECTION
  class: top-bar-section
  top: 0
  left: 0
  visible: true
- height: 45
  width: 504
  id: ''
  tag: UL
  class: right
  top: 0
  left: 296
  visible: true
- height: 45
  width: 86
  id: ''
  tag: LI
  class: active
  top: 0
  left: 296
  visible: true
- height: 45
  width: 86
  id: ''
  tag: A
  class: ''
  top: 0
  left: 296
  visible: true
- height: 45
  width: 94
  id: ''
  tag: LI
  class: active
  top: 0
  left: 382
  visible: true
- height: 45
  width: 94
  id: ''
  tag: A
  class: ''
  top: 0
  left: 382
  visible: true
- height: 45
  width: 70
  id: ''
  tag: LI
  class: active
  top: 0
  left: 476
  visible: true
- height: 45
  width: 70
  id: ''
  tag: A
  class: ''
  top: 0
  left: 476
  visible: true
- height: 45
  width: 78
  id: ''
  tag: LI
  class: active
  top: 0
  left: 546
  visible: true
- height: 45
  width: 78
  id: ''
  tag: A
  class: ''
  top: 0
  left: 546
  visible: true
- height: 45
  width: 78
  id: ''
  tag: LI
  class: active
  top: 0
  left: 624
  visible: true
- height: 45
  width: 78
  id: ''
  tag: A
  class: ''
  top: 0
  left: 624
  visible: true
- height: 45
  width: 98
  id: ''
  tag: LI
  class: has-dropdown not-click
  top: 0
  left: 702
  visible: true
- height: 45
  width: 98
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: true
- height: 0
  width: 0
  id: ''
  tag: UL
  class: dropdown
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: title back js-generated
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: H5
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 20
  width: 800
  id: ''
  tag: DIV
  class: row
  top: 45
  left: 0
  visible: true
- height: 20
  width: 800
  id: ''
  tag: DIV
  class: large-3 columns
  top: 45
  left: 0
  visible: true
- height: 0
  width: 770
  id: ''
  tag: P
  class: notice
  top: 0
  left: 15
  visible: true
- height: 0
  width: 770
  id: ''
  tag: P
  class: alert
  top: 20
  left: 15
  visible: true
- height: 0
  width: 800
  id: ''
  tag: DIV
  class: large-9 columns
  top: 65
  left: 0
  visible: true
- height: 164
  width: 800
  id: ''
  tag: DIV
  class: row
  top: 65
  left: 0
  visible: true
- height: 164
  width: 800
  id: ''
  tag: DIV
  class: large-12 columns
  top: 65
  left: 0
  visible: true
- height: 73
  width: 800
  id: ''
  tag: DIV
  class: row
  top: 0
  left: 0
  visible: true
- height: 73
  width: 800
  id: ''
  tag: DIV
  class: large-3 columns
  top: 0
  left: 0
  visible: true
- height: 62
  width: 770
  id: ''
  tag: H1
  class: ''
  top: 3
  left: 15
  visible: true
- height: 0
  width: 800
  id: ''
  tag: DIV
  class: large-9 columns
  top: 73
  left: 0
  visible: true
- height: 26
  width: 770
  id: ''
  tag: P
  class: ''
  top: 73
  left: 15
  visible: true
- height: 0
  width: 0
  id: ''
  tag: B
  class: ''
  top: 76
  left: 125
  visible: true
- height: 26
  width: 770
  id: ''
  tag: P
  class: ''
  top: 118
  left: 15
  visible: true
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 122
  left: 135
  visible: true
- height: 0
  width: 0
  id: ''
  tag: B
  class: ''
  top: 122
  left: 305
  visible: true
- height: 0
  width: 0
  id: ''
  tag: SCRIPT
  class: ''
  top: 0
  left: 0
  visible: false
      DATA
      YAML::load(data)
    end

    def travis_local_generated_master
      data = <<-DATA
---
- height: 45
  width: 800
  id: ''
  tag: DIV
  class: contain-to-grid fixed
  top: 0
  left: 0
  visible: true
- height: 45
  width: 800
  id: ''
  tag: NAV
  class: top-bar
  top: 0
  left: 0
  visible: true
- height: 45
  width: 143
  id: ''
  tag: UL
  class: title-area
  top: 0
  left: 0
  visible: true
- height: 45
  width: 143
  id: ''
  tag: LI
  class: name
  top: 0
  left: 0
  visible: true
- height: 45
  width: 143
  id: ''
  tag: H1
  class: ''
  top: 0
  left: 0
  visible: true
- height: 45
  width: 143
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: true
- height: 0
  width: 0
  id: ''
  tag: LI
  class: toggle-topbar menu-icon
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 800
  id: ''
  tag: SECTION
  class: top-bar-section
  top: 0
  left: 0
  visible: true
- height: 45
  width: 497
  id: ''
  tag: UL
  class: right
  top: 0
  left: 303
  visible: true
- height: 45
  width: 85
  id: ''
  tag: LI
  class: active
  top: 0
  left: 303
  visible: true
- height: 45
  width: 85
  id: ''
  tag: A
  class: ''
  top: 0
  left: 303
  visible: true
- height: 45
  width: 93
  id: ''
  tag: LI
  class: active
  top: 0
  left: 388
  visible: true
- height: 45
  width: 93
  id: ''
  tag: A
  class: ''
  top: 0
  left: 388
  visible: true
- height: 45
  width: 69
  id: ''
  tag: LI
  class: active
  top: 0
  left: 480
  visible: true
- height: 45
  width: 69
  id: ''
  tag: A
  class: ''
  top: 0
  left: 480
  visible: true
- height: 45
  width: 77
  id: ''
  tag: LI
  class: active
  top: 0
  left: 549
  visible: true
- height: 45
  width: 77
  id: ''
  tag: A
  class: ''
  top: 0
  left: 549
  visible: true
- height: 45
  width: 77
  id: ''
  tag: LI
  class: active
  top: 0
  left: 626
  visible: true
- height: 45
  width: 77
  id: ''
  tag: A
  class: ''
  top: 0
  left: 626
  visible: true
- height: 45
  width: 97
  id: ''
  tag: LI
  class: has-dropdown not-click
  top: 0
  left: 703
  visible: true
- height: 45
  width: 97
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: true
- height: 0
  width: 0
  id: ''
  tag: UL
  class: dropdown
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: title back js-generated
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: H5
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: LI
  class: ''
  top: 0
  left: 0
  visible: false
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 0
  left: 0
  visible: false
- height: 20
  width: 800
  id: ''
  tag: DIV
  class: row
  top: 45
  left: 0
  visible: true
- height: 20
  width: 800
  id: ''
  tag: DIV
  class: large-3 columns
  top: 45
  left: 0
  visible: true
- height: 0
  width: 770
  id: ''
  tag: P
  class: notice
  top: 0
  left: 15
  visible: true
- height: 0
  width: 770
  id: ''
  tag: P
  class: alert
  top: 20
  left: 15
  visible: true
- height: 0
  width: 800
  id: ''
  tag: DIV
  class: large-9 columns
  top: 65
  left: 0
  visible: true
- height: 164
  width: 800
  id: ''
  tag: DIV
  class: row
  top: 65
  left: 0
  visible: true
- height: 164
  width: 800
  id: ''
  tag: DIV
  class: large-12 columns
  top: 65
  left: 0
  visible: true
- height: 73
  width: 800
  id: ''
  tag: DIV
  class: row
  top: 0
  left: 0
  visible: true
- height: 73
  width: 800
  id: ''
  tag: DIV
  class: large-3 columns
  top: 0
  left: 0
  visible: true
- height: 62
  width: 770
  id: ''
  tag: H1
  class: ''
  top: 3
  left: 15
  visible: true
- height: 0
  width: 800
  id: ''
  tag: DIV
  class: large-9 columns
  top: 73
  left: 0
  visible: true
- height: 26
  width: 770
  id: ''
  tag: P
  class: ''
  top: 73
  left: 15
  visible: true
- height: 0
  width: 0
  id: ''
  tag: B
  class: ''
  top: 76
  left: 121
  visible: true
- height: 26
  width: 770
  id: ''
  tag: P
  class: ''
  top: 118
  left: 15
  visible: true
- height: 0
  width: 0
  id: ''
  tag: A
  class: ''
  top: 122
  left: 130
  visible: true
- height: 0
  width: 0
  id: ''
  tag: B
  class: ''
  top: 122
  left: 294
  visible: true
- height: 0
  width: 0
  id: ''
  tag: SCRIPT
  class: ''
  top: 0
  left: 0
  visible: false

      DATA
      YAML::load(data)
    end
  end
end