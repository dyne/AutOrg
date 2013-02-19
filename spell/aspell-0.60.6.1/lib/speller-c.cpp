/* Automatically generated file.  Do not edit directly. */

/* This file is part of The New Aspell
 * Copyright (C) 2001-2002 by Kevin Atkinson under the GNU LGPL
 * license version 2.0 or 2.1.  You should have received a copy of the
 * LGPL license along with this library if you did not you can find it
 * at http://www.gnu.org/.                                              */

#include "convert.hpp"
#include "error.hpp"
#include "mutable_string.hpp"
#include "posib_err.hpp"
#include "speller.hpp"
#include "word_list.hpp"

namespace acommon {

class CanHaveError;
class Config;
struct Error;
class Speller;
class WordList;

extern "C" CanHaveError * new_aspell_speller(Config * config)
{
  PosibErr<Speller *> ret = new_speller(config);
  if (ret.has_err()) {
    return new CanHaveError(ret.release_err());
  } else {
    return ret;
  }
}

extern "C" Speller * to_aspell_speller(CanHaveError * obj)
{
  return static_cast<Speller *>(obj);
}

extern "C" void delete_aspell_speller(Speller * ths)
{
  delete ths;
}

extern "C" unsigned int aspell_speller_error_number(const Speller * ths)
{
  return ths->err_ == 0 ? 0 : 1;
}

extern "C" const char * aspell_speller_error_message(const Speller * ths)
{
  return ths->err_ ? ths->err_->mesg : "";
}

extern "C" const Error * aspell_speller_error(const Speller * ths)
{
  return ths->err_;
}

extern "C" Config * aspell_speller_config(Speller * ths)
{
  return ths->config();
}

extern "C" int aspell_speller_check(Speller * ths, const char * word, int word_size)
{
  ths->temp_str_0.clear();
  ths->to_internal_->convert(word, word_size, ths->temp_str_0);
  unsigned int s0 = ths->temp_str_0.size();
  PosibErr<bool> ret = ths->check(MutableString(ths->temp_str_0.mstr(), s0));
  ths->err_.reset(ret.release_err());
  if (ths->err_ != 0) return -1;
  return ret.data;
}

extern "C" int aspell_speller_add_to_personal(Speller * ths, const char * word, int word_size)
{
  ths->temp_str_0.clear();
  ths->to_internal_->convert(word, word_size, ths->temp_str_0);
  unsigned int s0 = ths->temp_str_0.size();
  PosibErr<void> ret = ths->add_to_personal(MutableString(ths->temp_str_0.mstr(), s0));
  ths->err_.reset(ret.release_err());
  if (ths->err_ != 0) return 0;
  return 1;
}

extern "C" int aspell_speller_add_to_session(Speller * ths, const char * word, int word_size)
{
  ths->temp_str_0.clear();
  ths->to_internal_->convert(word, word_size, ths->temp_str_0);
  unsigned int s0 = ths->temp_str_0.size();
  PosibErr<void> ret = ths->add_to_session(MutableString(ths->temp_str_0.mstr(), s0));
  ths->err_.reset(ret.release_err());
  if (ths->err_ != 0) return 0;
  return 1;
}

extern "C" const WordList * aspell_speller_personal_word_list(Speller * ths)
{
  PosibErr<const WordList *> ret = ths->personal_word_list();
  ths->err_.reset(ret.release_err());
  if (ths->err_ != 0) return 0;
  if (ret.data)
    const_cast<WordList *>(ret.data)->from_internal_ = ths->from_internal_;
  return ret.data;
}

extern "C" const WordList * aspell_speller_session_word_list(Speller * ths)
{
  PosibErr<const WordList *> ret = ths->session_word_list();
  ths->err_.reset(ret.release_err());
  if (ths->err_ != 0) return 0;
  if (ret.data)
    const_cast<WordList *>(ret.data)->from_internal_ = ths->from_internal_;
  return ret.data;
}

extern "C" const WordList * aspell_speller_main_word_list(Speller * ths)
{
  PosibErr<const WordList *> ret = ths->main_word_list();
  ths->err_.reset(ret.release_err());
  if (ths->err_ != 0) return 0;
  if (ret.data)
    const_cast<WordList *>(ret.data)->from_internal_ = ths->from_internal_;
  return ret.data;
}

extern "C" int aspell_speller_save_all_word_lists(Speller * ths)
{
  PosibErr<void> ret = ths->save_all_word_lists();
  ths->err_.reset(ret.release_err());
  if (ths->err_ != 0) return 0;
  return 1;
}

extern "C" int aspell_speller_clear_session(Speller * ths)
{
  PosibErr<void> ret = ths->clear_session();
  ths->err_.reset(ret.release_err());
  if (ths->err_ != 0) return 0;
  return 1;
}

extern "C" const WordList * aspell_speller_suggest(Speller * ths, const char * word, int word_size)
{
  ths->temp_str_0.clear();
  ths->to_internal_->convert(word, word_size, ths->temp_str_0);
  unsigned int s0 = ths->temp_str_0.size();
  PosibErr<const WordList *> ret = ths->suggest(MutableString(ths->temp_str_0.mstr(), s0));
  ths->err_.reset(ret.release_err());
  if (ths->err_ != 0) return 0;
  if (ret.data)
    const_cast<WordList *>(ret.data)->from_internal_ = ths->from_internal_;
  return ret.data;
}

extern "C" int aspell_speller_store_replacement(Speller * ths, const char * mis, int mis_size, const char * cor, int cor_size)
{
  ths->temp_str_0.clear();
  ths->to_internal_->convert(mis, mis_size, ths->temp_str_0);
  unsigned int s0 = ths->temp_str_0.size();
  ths->temp_str_1.clear();
  ths->to_internal_->convert(cor, cor_size, ths->temp_str_1);
  unsigned int s1 = ths->temp_str_1.size();
  PosibErr<bool> ret = ths->store_replacement(MutableString(ths->temp_str_0.mstr(), s0), MutableString(ths->temp_str_1.mstr(), s1));
  ths->err_.reset(ret.release_err());
  if (ths->err_ != 0) return -1;
  return ret.data;
}



}

