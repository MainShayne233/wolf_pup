var indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

this.cdot_dealer = function(latex, step) {
  var val;
  step += 4;
  val = "*";
  return box_boy(val, step);
};

this.comb_dealer = function(latex, step) {
  var args, box, i, j, val;
  args = [];
  args[0] = "";
  args[1] = "";
  step += 6;
  for (i = j = 0; j <= 1; i = ++j) {
    step += 1;
    box = bracket_sniffer(latex, step);
    args[i] = box.val;
    step = box.step;
  }
  val = "%28%28" + args[0] + "%29+choose+%28" + args[1] + "%29%29";
  return box_boy(val, step);
};

this.frac_dealer = function(latex, step) {
  var args, box, rbrack_cnt, val;
  args = [];
  args[0] = "";
  step += 5;
  rbrack_cnt = 0;
  while (rbrack_cnt < 2) {
    step += 1;
    box = ups_guy(latex, step);
    val = box.val;
    if (val === ")") {
      rbrack_cnt += 1;
      if (rbrack_cnt < 2) {
        args[rbrack_cnt] = "";
      }
    } else if (!is_brack(val)) {
      if (val !== "(") {
        args[rbrack_cnt] += val;
      }
      step = box.step;
    }
  }
  args = args.map(function(i) {
    return "%28" + i + "%29";
  });
  args = '%28' + args.join("%2F") + '%29';
  return box_boy(args, step);
};

this.ge_dealer = function(latex, step) {
  var val;
  step += 2;
  val = '%3E%3D';
  return box_boy(val, step);
};

this.infty_dealer = function(latex, step) {
  var val;
  step += 5;
  val = 'infinity';
  return box_boy(val, step);
};

this.int_dealer = function(latex, step) {
  var arg, box, lims, ref, val;
  step += 4;
  lims = '';
  if ((ref = latex[step]) === '^' || ref === '_') {
    box = top_and_sub_sniffer(latex, step);
    lims = box.val;
    step = box.step;
  }
  box = int_sniffer(latex, step);
  arg = box.val;
  step = box.step;
  val = '%28integral' + lims + arg + '%29';
  return box_boy(val, step);
};

this.lbrack_dealer = function(latex, step) {
  var val;
  step += 5;
  if (latex[step] === '\\') {
    step += 1;
  }
  if (latex[step] === '(') {
    val = '%28';
  }
  if (latex[step] === '[') {
    val = '%5B';
  }
  if (latex[step] === '{') {
    val = '%7B';
  }
  return box_boy(val, step);
};

this.le_dealer = function(latex, step) {
  var val;
  step += 2;
  val = '%3C%3D';
  return box_boy(val, step);
};

this.lim_dealer = function(latex, step) {
  var arg, box, lim, val;
  step += 4;
  lim = '';
  if (latex[step] === '_') {
    step += 1;
    box = lim_script_sniffer(latex, step);
    lim = box.val;
    step = box.step;
    step += 1;
  }
  if (latex[step] === '{') {
    box = bracket_sniffer(latex, step);
    arg = box.val;
    step = box.step;
  } else {
    box = til_the_end_sniffer(latex, step);
    arg = box.val;
    step = box.step;
  }
  val = "%28lim+" + lim + arg + "%29";
  return box_boy(val, step);
};

this.pi_dealer = function(latex, step) {
  var val;
  step += 2;
  val = 'pi';
  return box_boy(val, step);
};

this.rbrack_dealer = function(latex, step) {
  var val;
  step += 6;
  if (latex[step] === '\\') {
    step += 1;
  }
  if (latex[step] === ')') {
    val = '%29';
  }
  if (latex[step] === ']') {
    val = '%5D';
  }
  if (latex[step] === '}') {
    val = '%7D';
  }
  return box_boy(val, step);
};

this.root_dealer = function(latex, step) {
  var arg, box;
  step += 5;
  box = latex[step] === "[" ? nth_root_dealer(latex, step) : sqrt_dealer(latex, step);
  arg = box.val;
  step = box.step;
  return box_boy(arg, step);
};

this.sum_dealer = function(latex, step) {
  var arg, box, lims, ref, val;
  step += 4;
  lims = '';
  if ((ref = latex[step]) === '^' || ref === '_') {
    box = top_and_sub_sniffer(latex, step);
    lims = box.val;
    step = box.step;
  }
  if ((latex.slice(step + 1, +(step + 4) + 1 || 9e9).join('')) === 'left') {
    box = paren_sniffer(latex, step);
    arg = box.val;
    step = box.step;
  } else {
    box = til_the_end_sniffer(latex, step);
    arg = box.val;
    step = box.step;
  }
  val = "%28sum+" + lims + arg + "%29%29";
  return box_boy(val, step);
};

this.to_dealer = function(latex, step) {
  step += 2;
  return box_boy("+to+", step);
};

this.is_cdot = function(latex, step) {
  return (latex.slice(step + 1, +(step + 4) + 1 || 9e9).join('')) === "cdot";
};

this.is_comb = function(latex, step) {
  return (latex.slice(step + 1, +(step + 5) + 1 || 9e9).join('')) === "binom";
};

this.is_frac = function(latex, step) {
  return (latex.slice(step + 1, +(step + 4) + 1 || 9e9).join('')) === 'frac';
};

this.is_ge = function(latex, step) {
  return (latex.slice(step + 1, +(step + 2) + 1 || 9e9).join('')) === 'ge';
};

this.is_infty = function(latex, step) {
  return (latex.slice(step + 1, +(step + 5) + 1 || 9e9).join('')) === 'infty';
};

this.is_int = function(latex, step) {
  return (latex.slice(step + 1, +(step + 3) + 1 || 9e9).join('')) === 'int';
};

this.is_lbrack = function(latex, step) {
  return (latex.slice(step + 1, +(step + 4) + 1 || 9e9).join('')) === 'left';
};

this.is_le = function(latex, step) {
  return (latex.slice(step + 1, +(step + 2) + 1 || 9e9).join('')) === 'le';
};

this.is_lpar = function(latex, step) {
  return (latex.slice(step + 1, +(step + 5) + 1 || 9e9).join('')) === 'lpar';
};

this.is_lim = function(latex, step) {
  return (latex.slice(step + 1, +(step + 3) + 1 || 9e9).join('')) === 'lim';
};

this.is_multiply = function(latex, step) {
  return (latex.slice(step + 1, +(step + 4) + 1 || 9e9).join('')) === 'cdot';
};

this.is_nthroot = function(latex, step) {
  return (latex.slice(step + 1, +(step + 7) + 1 || 9e9).join('')) === 'nthroot';
};

this.is_pi = function(latex, step) {
  return (latex.slice(step + 1, +(step + 2) + 1 || 9e9).join('')) === 'pi';
};

this.is_prod = function(latex, step) {
  return (latex.slice(step + 1, +(step + 4) + 1 || 9e9).join('')) === 'prod';
};

this.is_rbrack = function(latex, step) {
  return (latex.slice(step + 1, +(step + 5) + 1 || 9e9).join('')) === 'right';
};

this.is_rpar = function(latex, step) {
  return (latex.slice(step + 1, +(step + 5) + 1 || 9e9).join('')) === 'right';
};

this.is_root = function(latex, step) {
  return (latex.slice(step + 1, +(step + 4) + 1 || 9e9).join('')) === 'sqrt';
};

this.is_sum = function(latex, step) {
  return (latex.slice(step + 1, +(step + 3) + 1 || 9e9).join('')) === 'sum';
};

this.is_text = function(latex, step) {
  return (latex.slice(step + 1, +(step + 4) + 1 || 9e9).join('')) === 'text';
};

this.is_to = function(latex, step) {
  return (latex.slice(step + 1, +(step + 2) + 1 || 9e9).join('')) === 'to';
};

this.is_brack = function(str) {
  return str === '{' || str === '}';
};

this.is_backslash = function(str) {
  return str === "\\";
};

this.is_norm = function(str) {
  var array, j, results;
  array = (function() {
    results = [];
    for (var j = '0'; '0' <= '9' ? j <= '9' : j >= '9'; '0' <= '9' ? j++ : j--){ results.push(j); }
    return results;
  }).apply(this);
  array += "abcdefghijklmnopqrstuvwxyz".split('');
  array += ['-', '.'];
  array += ['[', ']'];
  array += ['!'];
  return indexOf.call(array, str) >= 0;
};

this.is_special = function(str) {
  var array;
  array = ['+', '=', '<', '>', ',', '[', ']', '(', ')'];
  return indexOf.call(array, str) >= 0;
};

this.is_space = function(str) {
  return str === ' ';
};

this.is_expo = function(str) {
  return str === '^';
};

this.backslash_dealer = function(latex, step) {
  var j, len, t, types;
  types = ['cdot', 'comb', 'frac', 'ge', 'infty', 'int', 'lbrack', 'le', 'lim', 'pi', 'rbrack', 'root', 'sum', 'to'];
  for (j = 0, len = types.length; j < len; j++) {
    t = types[j];
    if (this["is_" + t](latex, step)) {
      return this[t + "_dealer"](latex, step);
    }
  }
};

this.brack_dealer = function(latex, step) {
  var val;
  val = latex[step] === "{" ? "(" : ")";
  return box_boy(val, step);
};

this.norm_dealer = function(latex, step) {
  var val;
  val = latex[step];
  return box_boy(val, step);
};

this.expo_dealer = function(latex, step) {
  var arg, box, val;
  step += 1;
  if (latex[step] === '{') {
    box = bracket_sniffer(latex, step);
    arg = box.val;
    step = box.step;
  } else {
    arg = latex[step];
  }
  val = '%5E' + '%28' + arg + '%29';
  return box_boy(val, step);
};

this.space_dealer = function(latex, step) {
  return box_boy('', step);
};

this.int_sniffer = function(latex, step) {
  var arg, box;
  arg = '';
  while (latex[step] !== 'd') {
    box = ups_guy(latex, step);
    if (box.val !== 'd') {
      arg += box.val;
      step = box.step;
    }
    step += 1;
  }
  step += 1;
  return box_boy(arg, step);
};

this.sqrt_dealer = function(latex, step) {
  var arg, box, val;
  box = bracket_sniffer(latex, step);
  arg = box.val;
  val = '%28sqrt%28' + arg + '%29%29';
  step = box.step;
  return box_boy(val, step);
};

this.nth_root_dealer = function(latex, step) {
  var args, box, val;
  args = [];
  box = square_bracket_sniffer(latex, step);
  args[0] = box.val;
  step = box.step;
  step += 1;
  box = bracket_sniffer(latex, step);
  args[1] = box.val;
  step = box.step;
  val = "%28" + args[0] + 'th+root+of+%28' + args[1] + "%29%29";
  return box_boy(val, step);
};

this.bracket_sniffer = function(latex, step) {
  var arg, box;
  arg = '';
  while (true) {
    box = ups_guy(latex, step);
    if (box.val === ')') {
      break;
    }
    step = box.step;
    if (box.val !== '(') {
      arg += box.val;
    }
    step += 1;
  }
  return box_boy(arg, step);
};

this.square_bracket_sniffer = function(latex, step) {
  var arg, box;
  arg = '';
  while (true) {
    box = ups_guy(latex, step);
    if (box.val === ']') {
      break;
    }
    step = box.step;
    if (box.val !== '[' && box.val !== ']') {
      arg += box.val;
    }
    step += 1;
  }
  return box_boy(arg, step);
};

this.lim_script_sniffer = function(latex, step) {
  var box, val;
  step += 1;
  box = bracket_sniffer(latex, step);
  val = "%28" + box.val + "%29+";
  step = box.step;
  return box_boy(val, step);
};

this.paren_sniffer = function(latex, step) {
  var arg, box, val;
  arg = '';
  while (true) {
    box = ups_guy(latex, step);
    if (box.val === '%29') {
      break;
    }
    step = box.step;
    arg += box.val;
    step += 1;
  }
  step += 6;
  val = '%28' + arg + '%29';
  return box_boy(arg, step);
};

this.til_the_end_sniffer = function(latex, step) {
  var arg, box;
  arg = '';
  while (step < latex.length) {
    box = ups_guy(latex, step);
    arg += box.val;
    step = box.step;
    step += 1;
  }
  return box_boy(arg, step);
};

this.top_and_sub_sniffer = function(latex, step) {
  var args, box, flip, i, j, val;
  args = ['', ''];
  flip = latex[step] === '^';
  step += 1;
  for (i = j = 0; j <= 1; i = ++j) {
    if (latex[step] === '{') {
      box = bracket_sniffer(latex, step);
      args[i] = box.val;
      step = box.step;
      step += 2;
    } else {
      args[i] = latex[step];
      step += 2;
    }
  }
  if (flip) {
    args.reverse();
  }
  val = "+%28" + args[0] + "+to+" + args[1] + "%29+";
  step -= 1;
  return box_boy(val, step);
};

this.special_dealer = function(latex, step) {
  var arg, char;
  char = latex[step];
  switch (false) {
    case char !== '+':
      arg = '%2B';
      break;
    case char !== '=':
      arg = '%3D';
      break;
    case char !== '<':
      arg = '%3C';
      break;
    case char !== '>':
      arg = '%3E';
      break;
    case char !== ',':
      arg = '%2C';
      break;
    case char !== '[':
      arg = '%5B';
      break;
    case char !== ']':
      arg = '%5D';
      break;
    case char !== '(':
      arg = '%28';
      break;
    case char !== ')':
      arg = '%29';
      break;
    default:
      arg = "";
  }
  return box_boy(arg, step);
};

this.wolfram = function() {
  var latex, url_base, url_tail;
  url_base = 'http://www.wolframalpha.com/input/?i=';
  latex = getLatex();
  url_tail = wolf_parse(latex);
  return OpenNewTab(url_base + url_tail);
};

this.OpenNewTab = function(url) {
  var win;
  win = window.open(url, '_blank');
  return win.focus();
};

this.append = function() {
  var str;
  str = 'he';
  return this[str + 'llo']();
};

this.box_boy = function(val, step) {
  var box;
  box = {};
  box.val = val;
  box.step = step;
  return box;
};

this.ups_guy = function(latex, step) {
  var chr, d, destinations, j, len;
  chr = latex[step];
  destinations = ['brack', 'backslash', 'expo', 'norm', 'space', 'special'];
  for (j = 0, len = destinations.length; j < len; j++) {
    d = destinations[j];
    if (this['is_' + d](chr)) {
      return this[d + '_dealer'](latex, step);
    }
  }
  return alert("ups guy didn't get correct address when latex[step] = " + latex[step] + " and step = " + step);
};

this.wolf_parse = function(latex) {
  var arg, box, step;
  latex = latex.split("");
  step = 0;
  box = til_the_end_sniffer(latex, step);
  arg = box.val;
  step = box.step;
  document.getElementById('output2').innerHTML = arg;
  return arg;
};

// ---
// generated by coffee-script 1.9.2