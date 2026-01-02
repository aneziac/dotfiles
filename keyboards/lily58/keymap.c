#include QMK_KEYBOARD_H

enum layer_number {
  _QWERTY,
  _NAV,
  _SYM,
};

#define NAV MO(_NAV)
#define SYM MO(_SYM)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

/* QWERTY
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * |  `   |   1  |   2  |   3  |   4  |   5  |                    |   6  |   7  |   8  |   9  |   0  |  -   |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | Tab  |   Q  |   W  |   E  |   R  |   T  |                    |   Y  |   U  |   I  |   O  |   P  |  \   |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | ESC  |   A  |   S  |   D  |   F  |   G  |-------.    ,-------|   H  |   J  |   K  |   L  |   ;  |  '   |
 * |------+------+------+------+------+------|  C+A  |    |       |------+------+------+------+------+------|
 * |LShift|   Z  |   X  |   C  |   V  |   B  |-------|    |-------|   N  |   M  |   ,  |   .  |   /  |RShift|
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *                   |LCTRL |LGUI  | NAV  | /Space  /       \Enter \  | SYM  |BackSP| RAlt |
 *                   |      |      |      |/       /         \      \ |      |      |      |
 *                   `----------------------------'           '------''--------------------'
 */
[_QWERTY] = LAYOUT(
  KC_GRV,      KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                         KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_MINS,
  KC_TAB,      KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                         KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_BSLS,
  KC_ESC,      KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                         KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT,
  KC_LSFT,     KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    LCTL(KC_A), XXXXXXX, KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_RSFT,
                                 KC_LCTL, KC_LGUI, NAV,     KC_SPC,     KC_ENT,  SYM,     KC_BSPC, KC_RALT
),

/* NAVIGATION, configured for i3 + vim
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * | F1   | S+1  | S+2  | S+3  | S+4  | S+5  |                    | S+6  | S+7  | S+8  | S+9  | S+0  |      |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | CS+C | CS+V | S+H  | S+J  | S+K  | S+L  |                    | Home | PgDn | PgUp | End  |      |      |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | C+U  | C+D  | LEFT | DOWN | UP   | RIGHT|-------.    ,-------| C+H  | C+J  | C+K  | C+L  |      |      |
 * |------+------+------+------+------+------|   {   |    |  }    |------+------+------+------+------+------|
 * | F12  | S+Z  | SS+H | SS+J | SS+K | S+L  |-------|    |-------|  F2  |  F3  |  F4  |  F5  |  F6  |      |
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *                   |LCTRL | LGUI | NAV  | /Space  /       \Enter \  | SYM  |BackSP| RAlt |
 *                   |      |      |      |/       /         \      \ |      |      |      |
 *                   `----------------------------'           '------''--------------------'
 */
[_NAV] = LAYOUT(
  KC_F1,            LGUI(KC_1),       LGUI(KC_2),       LGUI(KC_3),       LGUI(KC_4),       LGUI(KC_5),                               LGUI(KC_6), LGUI(KC_7), LGUI(KC_8), LGUI(KC_9), LGUI(KC_0), XXXXXXX,
  LCTL(LSFT(KC_C)), LCTL(LSFT(KC_V)), LGUI(KC_H),       LGUI(KC_J),       LGUI(KC_K),       LGUI(KC_L),                               KC_HOME,    KC_PGDN,    KC_PGUP,    KC_END,     XXXXXXX,    XXXXXXX,
  LCTL(KC_U),       LCTL(KC_D),       KC_LEFT,          KC_DOWN,          KC_UP,            KC_RIGHT,                                 KC_H,       KC_J,       KC_K,       KC_L,       XXXXXXX,    XXXXXXX,
  KC_F12,           LGUI(KC_Z),       LSFT(LGUI(KC_H)), LSFT(LGUI(KC_J)), LSFT(LGUI(KC_K)), LSFT(LGUI(KC_L)), KC_LCBR,    KC_RCBR,    KC_F5,      KC_F2,      KC_F3,      KC_F4,      KC_F7,      XXXXXXX,
                                      _______,          _______,          _______,          _______,          _______,    _______,    _______,    _______
),

/* SYMBOLS
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * |  F1  |  F2  |  F3  |  F4  |  F5  |  F6  |                    |  F7  |  F8  |  F9  | F10  | F11  | F12  |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |  ~   |  !   |  @   |  #   |  $   |  %   |                    |  ^   |  &   |  *   |  7   |  8   |  9   |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |  ?   |  (   |  )   |  {   |  }   |  +   |-------.    ,-------|  =   |  :   |  "   |  4   |  5   |  6   |
 * |------+------+------+------+------+------|  C+A  |    |       |------+------+------+------+------+------|
 * |      |      |  |   |  [   |  ]   |  _   |-------|    |-------|  <   |  >   |  0   |  1   |  2   |  3   |
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *                   |LCTRL | LGUI | NAV  | /Space  /       \Enter \  | SYM  |BackSP| RAlt |
 *                   |      |      |      |/       /         \      \ |      |      |      |
 *                   `----------------------------'           '------''--------------------'
 */

[_SYM] = LAYOUT(
  KC_F1,       KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,                        KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,
  KC_TILD,     KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_PERC,                      KC_CIRC, KC_AMPR, KC_ASTR, KC_P7,   KC_P8,   KC_P9,
  KC_QUES,     KC_LPRN, KC_RPRN, KC_LCBR, KC_RCBR, KC_PLUS,                      KC_EQL,  KC_COLN, KC_DQUO, KC_P4,   KC_P5,   KC_P6,
  XXXXXXX,     XXXXXXX, KC_PIPE, KC_LBRC, KC_RBRC, KC_UNDS, LCTL(KC_A), XXXXXXX, KC_LT,   KC_GT,   KC_P0,   KC_P1,   KC_P2,   KC_P3,
                                 _______, _______, _______, _______,    _______, _______, _______, _______
)};

