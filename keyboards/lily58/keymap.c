#include QMK_KEYBOARD_H

enum layer_number {
  _GALLIUM = 0,
  _NAV,
  _SYMBOLS,
  _ADJUST,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

/* Gallium (column staggered) - note C+A is tmux leader
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * | C+A  |   1  |   2  |   3  |   4  |   5  |                    |   6  |   7  |   8  |   9  |   0  |  -   |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | Tab  |   B  |   L  |   D  |   C  |   V  |                    |   J  |   Y  |   O  |   U  |   ,  |  +   |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | ESC  |   N  |   R  |   T  |   S  |   G  |-------.    ,-------|   P  |   H  |   A  |   E  |   I  |  /   |
 * |------+------+------+------+------+------|   [   |    |    ]  |------+------+------+------+------+------|
 * |LShift|   X  |   Q  |   M  |   W  |   Z  |-------|    |-------|   K  |   F  |   '  |   ;  |   .  |RShift|
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *                   | LAlt |LCTRL |LOWER | /Space  /       \Enter \  |RAISE |BackSP|RCTRL |
 *                   |      |      |      |/       /         \      \ |      |      |      |
 *                   `----------------------------'           '------''--------------------'
 */
[_GALLIUM] = LAYOUT(
  LCTL(KC_A),  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                      KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_MINS,
  KC_TAB,      KC_B,    KC_L,    KC_D,    KC_C,    KC_V,                      KC_J,    KC_Y,    KC_O,    KC_U,    KC_COMM, KC_PLUS,
  KC_ESC,      KC_N,    KC_R,    KC_T,    KC_S,    KC_G,                      KC_P,    KC_H,    KC_A,    KC_E,    KC_I,    KC_SLSH,
  KC_LSFT,     KC_X,    KC_Q,    KC_M,    KC_W,    KC_Z,    KC_LBRC, KC_RBRC, KC_K,    KC_F,    KC_QUOT, KC_SCLN, KC_DOT,  KC_RSFT,
                                 KC_LALT, KC_LCTL, MO(_LOWER), KC_SPC, KC_ENT, MO(_RAISE), KC_BSPC, KC_RCTL
),

/* NAV, configured for i3 + vim
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * |      | S+1  | S+2  | S+3  | S+4  | S+5  |                    | S+6  | S+7  | S+8  | S+9  | S+0  |      |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | Tab  | S+H  | S+J  | S+K  | S+L  |      |                    | Home | PgDn | PgUp | End  |  {   |  }   |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |      | C+U  | C+D  |      |      |      |-------.    ,-------|      |  H   |  J   |  K   |  L   |      |
 * |------+------+------+------+------+------|   {   |    |  }    |------+------+------+------+------+------|
 * |      | SS+H | SS+J | SS+K | SS+L |      |-------|    |-------|      |      |      |      |      |      |
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *                   | LAlt |LCTRL |LOWER | /Space  /       \Enter \  |RAISE |BackSP|RCTRL |
 *                   |      |      |      |/       /         \      \ |      |      |      |
 *                   `----------------------------'           '------''--------------------'
 */
[_NAV] = LAYOUT(
  _______,     LGUI(KC_1), LGUI(KC_2), LGUI(KC_3), LGUI(KC_4), LGUI(KC_5),                LGUI(KC_6), LGUI(KC_7), LGUI(KC_8), LGUI(KC_9), LGUI(KC_0), _______,
  KC_TAB,      LGUI(KC_H), LGUI(KC_J), LGUI(KC_K), LGUI(KC_L), _______,                   KC_HOME,    KC_PGDN,    KC_PGUP,    KC_END,     KC_LCBR,    KC_RCBR,
  _______,     LCTL(KC_U), LCTL(KC_D), _______,    _______,    _______,                   _______,    KC_H,       KC_J,       KC_K,       KC_L,       _______,
  _______,     LSFT(LGUI(KC_H)), LSFT(LGUI(KC_J)), LSFT(LGUI(KC_K)), LSFT(LGUI(KC_L)), _______, KC_LCBR, KC_R, _______, _______, _______, _______, _______, _______,
                                 _______, _______, _______, _______, _______, _______, _______, KC_RCTL
),

/* SYMBOLS
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * |  `   |   1  |   2  |   3  |   4  |   5  |                    |   6  |   7  |   8  |   9  |   0  |  =   |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |  F1  |  F2  |  F3  |  F4  |  F5  |  F6  |                    |  F7  |  F8  |  F9  | F10  | F11  | F12  |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |  ~   |  !   |  @   |  #   |  $   |  %   |-------.    ,-------|  ^   |  &   |  *   |  :   |  ;   |  +   |
 * |------+------+------+------+------+------|   \   |    |   |   |------+------+------+------+------+------|
 * |      |  (   |  )   |  <   |  >   |  [   |-------|    |-------|  ]   |  {   |  }   |  -   |  _   |      |
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *                   | LAlt |LCTRL |LOWER | /Space  /       \Enter \  |RAISE |BackSP|LCTRL |
 *                   |      |      |      |/       /         \      \ |      |      |      |
 *                   `----------------------------'           '------''--------------------'
 */
[_SYMBOLS] = LAYOUT(
  KC_GRV,      KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                      KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_EQL,
  KC_F1,       KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,                     KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,
  KC_TILD,     KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_PERC,                   KC_CIRC, KC_AMPR, KC_ASTR, KC_COLN, KC_SCLN, KC_PLUS,
  _______,     KC_LPRN, KC_RPRN, KC_LT,   KC_GT,   KC_LBRC, KC_BSLS, KC_PIPE, KC_RBRC, KC_LCBR, KC_RCBR, KC_MINS, KC_UNDS, _______,
                                 _______, _______, _______, _______, _______, _______, _______, KC_LCTL
),

/* ADJUST
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * |      |      |      |      |      |      |                    |      |      |      |      |      |      |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |      |      |      |      |      |      |                    |      |      |      |      |      |      |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |      |      |      |      |      |      |-------.    ,-------|      |      |RGB ON| HUE+ | SAT+ | VAL+ |
 * |------+------+------+------+------+------|       |    |       |------+------+------+------+------+------|
 * |      |      |      |      |      |      |-------|    |-------|      |      | MODE | HUE- | SAT- | VAL- |
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *                   | LAlt | LGUI |LOWER | /Space  /       \Enter \  |RAISE |BackSP| RGUI |
 *                   |      |      |      |/       /         \      \ |      |      |      |
 *                   `----------------------------'           '------''--------------------'
 */
  [_ADJUST] = LAYOUT(
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
                             _______, _______, _______, _______, _______,  _______, _______, _______
  )
};

layer_state_t layer_state_set_user(layer_state_t state) {
  return update_tri_layer_state(state, _LOWER, _RAISE, _ADJUST);
}

//SSD1306 OLED update loop, make sure to enable OLED_ENABLE=yes in rules.mk
#ifdef OLED_ENABLE

oled_rotation_t oled_init_user(oled_rotation_t rotation) {
  if (!is_keyboard_master())
    return OLED_ROTATION_180;  // flips the display 180 degrees if offhand
  return rotation;
}

// When you add source files to SRC in rules.mk, you can use functions.
const char *read_layer_state(void);
const char *read_logo(void);
void set_keylog(uint16_t keycode, keyrecord_t *record);
const char *read_keylog(void);
const char *read_keylogs(void);

// const char *read_mode_icon(bool swap);
// const char *read_host_led_state(void);
// void set_timelog(void);
// const char *read_timelog(void);

bool oled_task_user(void) {
  if (is_keyboard_master()) {
    // If you want to change the display of OLED, you need to change here
    oled_write_ln(read_layer_state(), false);
    oled_write_ln(read_keylog(), false);
    oled_write_ln(read_keylogs(), false);
    //oled_write_ln(read_mode_icon(keymap_config.swap_lalt_lgui), false);
    //oled_write_ln(read_host_led_state(), false);
    //oled_write_ln(read_timelog(), false);
  } else {
    oled_write(read_logo(), false);
  }
    return false;
}
#endif // OLED_ENABLE

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  if (record->event.pressed) {
#ifdef OLED_ENABLE
    set_keylog(keycode, record);
#endif
    // set_timelog();
  }
  return true;
}
