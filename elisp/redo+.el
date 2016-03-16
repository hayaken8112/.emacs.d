<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: redo+.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="http://www.emacswiki.org/emacs?action=edit;id=redo%2b.el" />
<link type="text/css" rel="stylesheet" href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.0/css/bootstrap-combined.min.css" />
<link type="text/css" rel="stylesheet" href="/css/bootstrap.css" />
<meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="http://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: redo+.el" href="http://www.emacswiki.org/emacs?action=rss;rcidonly=redo%2b.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="http://www.emacswiki.org/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="http://www.emacswiki.org/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="http://www.emacswiki.org/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for redo+.el only"
      href="http://www.emacswiki.org/emacs?action=rss;rcidonly=redo%2b.el" /><meta name="viewport" content="width=device-width" />
<script type="text/javascript" src="/outliner.0.5.0.62-toc.js"></script>
<script type="text/javascript">

  function addOnloadEvent(fnc) {
    if ( typeof window.addEventListener != "undefined" )
      window.addEventListener( "load", fnc, false );
    else if ( typeof window.attachEvent != "undefined" ) {
      window.attachEvent( "onload", fnc );
    }
    else {
      if ( window.onload != null ) {
	var oldOnload = window.onload;
	window.onload = function ( e ) {
	  oldOnload( e );
	  window[fnc]();
	};
      }
      else
	window.onload = fnc;
    }
  }

  // https://stackoverflow.com/questions/280634/endswith-in-javascript
  if (typeof String.prototype.endsWith !== 'function') {
    String.prototype.endsWith = function(suffix) {
      return this.indexOf(suffix, this.length - suffix.length) !== -1;
    };
  }

  var initToc=function() {

    var outline = HTML5Outline(document.body);
    if (outline.sections.length == 1) {
      outline.sections = outline.sections[0].sections;
    }

    if (outline.sections.length > 1
	|| outline.sections.length == 1
           && outline.sections[0].sections.length > 0) {

      var toc = document.getElementById('toc');

      if (!toc) {
	var divs = document.getElementsByTagName('div');
	for (var i = 0; i < divs.length; i++) {
	  if (divs[i].getAttribute('class') == 'toc') {
	    toc = divs[i];
	    break;
	  }
	}
      }

      if (!toc) {
	var h2 = document.getElementsByTagName('h2')[0];
	if (h2) {
	  toc = document.createElement('div');
	  toc.setAttribute('class', 'toc');
	  h2.parentNode.insertBefore(toc, h2);
	}
      }

      if (toc) {
        var html = outline.asHTML(true);
        toc.innerHTML = html;

	items = toc.getElementsByTagName('a');
	for (var i = 0; i < items.length; i++) {
	  while (items[i].textContent.endsWith('â')) {
            var text = items[i].childNodes[0].nodeValue;
	    items[i].childNodes[0].nodeValue = text.substring(0, text.length - 1);
	  }
	}
      }
    }
  }

  addOnloadEvent(initToc);
  </script>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://emacswiki.org/bootstrap.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head><body class="default"><div class="header"><div class="menu"><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a href="http://www.emacswiki.org/emacs/Search" class="local">Search</a> <a href="http://www.emacswiki.org/emacs/ElispArea" class="local">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a href="http://www.emacswiki.org/emacs/Glossary" class="local">Glossary</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a href="http://www.emacswiki.org/emacs/Problems" class="local">Problems</a> <a href="http://www.emacswiki.org/emacs/Suggestions" class="local">Suggestions</a> </span><form method="get" action="http://www.emacswiki.org/emacs" enctype="multipart/form-data" accept-charset="utf-8" class="search"><p><label for="search">Search:</label> <input type="text" name="search"  size="20" accesskey="f" id="search" /> <label for="searchlang">Language:</label> <input type="text" name="lang"  size="10" id="searchlang" /> <input type="submit" name="dosearch" value="Go!" /></p></form></div><h1><a href="http://www.emacswiki.org/emacs?search=%22redo%2b%5c.el%22" rel="nofollow" title="Click to search for references to this page">redo+.el</a></h1></div><div class="wrapper"><div class="content browse"><p class="download"><a href="http://www.emacswiki.org/emacs/download/redo%2b.el">Download</a></p><pre><span class="comment">;;; redo+.el --- Redo/undo system for Emacs</span>

<span class="comment">;; Copyright (C) 1985, 1986, 1987, 1993-1995 Free Software Foundation, Inc.</span>
<span class="comment">;; Copyright (C) 1995 Tinker Systems and INS Engineering Corp.</span>
<span class="comment">;; Copyright (C) 1997 Kyle E. Jones</span>
<span class="comment">;; Copyright (C) 2008, 2009, 2013 S. Irie</span>

<span class="comment">;; Author: Kyle E. Jones, February 1997</span>
<span class="comment">;;         S. Irie, March 2008</span>
<span class="comment">;; Keywords: lisp, extensions</span>

<span class="comment">;; This program is free software; you can redistribute it and/or</span>
<span class="comment">;; modify it under the terms of the GNU General Public License as</span>
<span class="comment">;; published by the Free Software Foundation; either version 2, or</span>
<span class="comment">;; (at your option) any later version.</span>

<span class="comment">;; It is distributed in the hope that it will be useful, but WITHOUT</span>
<span class="comment">;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY</span>
<span class="comment">;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public</span>
<span class="comment">;; License for more details.</span>

<span class="comment">;; You should have received a copy of the GNU General Public</span>
<span class="comment">;; License along with this program; if not, write to the Free</span>
<span class="comment">;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,</span>
<span class="comment">;; MA 02111-1307 USA</span>


<span class="comment">;;; Commentary:</span>

<span class="comment">;; redo+.el is bug fix and extended version of XEmacs' redo package.</span>

<span class="comment">;; Emacs' normal undo system allows you to undo an arbitrary</span>
<span class="comment">;; number of buffer changes.  These undos are recorded as ordinary</span>
<span class="comment">;; buffer changes themselves.  So when you break the chain of</span>
<span class="comment">;; undos by issuing some other command, you can then undo all</span>
<span class="comment">;; the undos.  The chain of recorded buffer modifications</span>
<span class="comment">;; therefore grows without bound, truncated only at garbage</span>
<span class="comment">;; collection time.</span>
<span class="comment">;;</span>
<span class="comment">;; The redo/undo system is different in two ways:</span>
<span class="comment">;;   1. The undo/redo command chain is only broken by a buffer</span>
<span class="comment">;;      modification.  You can move around the buffer or switch</span>
<span class="comment">;;      buffers and still come back and do more undos or redos.</span>
<span class="comment">;;   2. The `<span class="constant important">redo</span>' command rescinds the most recent undo without</span>
<span class="comment">;;      recording the change as a _new_ buffer change.  It</span>
<span class="comment">;;      completely reverses the effect of the undo, which</span>
<span class="comment">;;      includes making the chain of buffer modification records</span>
<span class="comment">;;      shorter by one, to counteract the effect of the undo</span>
<span class="comment">;;      command making the record list longer by one.</span>

<span class="comment">;;</span>
<span class="comment">;; Installation:</span>
<span class="comment">;;</span>
<span class="comment">;; Save this file as redo+.el, byte compile it and put the</span>
<span class="comment">;; resulting redo.elc file in a directory that is listed in</span>
<span class="comment">;; load-path.</span>
<span class="comment">;;</span>
<span class="comment">;; In your .emacs file, add</span>
<span class="comment">;;   (<span class="keyword">require</span> '<span class="constant">redo+</span>)</span>
<span class="comment">;; and the system will be enabled.</span>
<span class="comment">;;</span>
<span class="comment">;; In addition, if you don't want to redo a previous undo, add</span>
<span class="comment">;;   (setq undo-no-redo t)</span>
<span class="comment">;; You can also use a function `<span class="constant important">undo-only</span>' instead of `<span class="constant important">undo</span>'</span>
<span class="comment">;; in GNU Emacs 22 or later.</span>


<span class="comment">;; History:</span>
<span class="comment">;; 2013-11-17  S. Irie</span>
<span class="comment">;;         * Fix the time entry not properly generated on Emacs 24</span>
<span class="comment">;;         * Use `<span class="constant important">user-error</span>' if available</span>
<span class="comment">;;         * Version 1.19</span>
<span class="comment">;;</span>
<span class="comment">;; 2013-10-19  S. Irie</span>
<span class="comment">;;         * Fix package.el/MELPA issue (<span class="string">"---"</span> in the first line required)</span>
<span class="comment">;;         * Version 1.18</span>
<span class="comment">;;</span>
<span class="comment">;; 2013-10-12  S. Irie</span>
<span class="comment">;;         * Fix errors that occur on Emacs 22/24</span>
<span class="comment">;;           (The fix in 1.16 was incorrect.  It actually did nothing.)</span>
<span class="comment">;;         * Version 1.17</span>
<span class="comment">;;</span>
<span class="comment">;; 2013-04-23  HenryVIII</span>
<span class="comment">;;         * Fix for GNU bug report #12581</span>
<span class="comment">;;         * Version 1.16</span>
<span class="comment">;;</span>
<span class="comment">;; 2009-01-07  S. Irie</span>
<span class="comment">;;         * Delete unnecessary messages</span>
<span class="comment">;;         * Bug fix</span>
<span class="comment">;;         * Version 1.15</span>
<span class="comment">;;</span>
<span class="comment">;; 2008-05-23  S. Irie</span>
<span class="comment">;;         * Bug fix</span>
<span class="comment">;;         * Version 1.14</span>
<span class="comment">;;</span>
<span class="comment">;; 2008-05-11  S. Irie</span>
<span class="comment">;;         * Record unmodified status entry when redoing</span>
<span class="comment">;;         * Version 1.13</span>
<span class="comment">;;</span>
<span class="comment">;; 2008-05-10  S. Irie</span>
<span class="comment">;;         * Bug fix</span>
<span class="comment">;;         * Version 1.12</span>
<span class="comment">;;</span>
<span class="comment">;; 2008-05-09  S. Irie</span>
<span class="comment">;;         * Bug fix</span>
<span class="comment">;;         * Version 1.11</span>
<span class="comment">;;</span>
<span class="comment">;; 2008-04-02  S. Irie</span>
<span class="comment">;;         * undo-no-redo available</span>
<span class="comment">;;         * GNU Emacs menu-bar and tool-bar item</span>
<span class="comment">;;         * Bug fix</span>
<span class="comment">;;         * Version 1.10</span>

<span class="comment">;; ToDo:</span>
<span class="comment">;;</span>
<span class="comment">;; - undo/redo in region</span>

<span class="comment">;;; Code:</span>

(<span class="keyword">defvar</span> <span class="variable">redo-version</span> <span class="string">"1.19"</span>
  <span class="string">"Version number for the Redo+ package."</span>)

(<span class="keyword">defvar</span> <span class="variable">last-buffer-undo-list</span> nil
  <span class="string">"The head of buffer-undo-list at the last time an undo or redo was done."</span>)
(make-variable-buffer-local 'last-buffer-undo-list)

(make-variable-buffer-local 'pending-undo-list)

<span class="comment">;; Emacs 20 variable</span>
<span class="comment">;;(<span class="keyword">defvar</span> <span class="variable">undo-in-progress</span>) ; Emacs 20 is no longer supported.</span>

<span class="comment">;; Emacs 21 variable</span>
(<span class="keyword">defvar</span> <span class="variable">undo-no-redo</span> nil)

(<span class="keyword">defun</span> <span class="function">redo-error</span> (format <span class="type">&amp;rest</span> args)
  <span class="string">"Call `<span class="constant important">user-error</span>' if available.  Otherwise, use `<span class="constant important">error</span>' instead."</span>
  (<span class="keyword elisp">if</span> (fboundp 'user-error)
      (apply 'user-error format args)
    (apply 'error format args)))

(<span class="keyword">defun</span> <span class="function">redo</span> (<span class="type">&amp;optional</span> count)
  <span class="string">"Redo the the most recent undo.
Prefix arg COUNT means redo the COUNT most recent undos.
If you have modified the buffer since the last redo or undo,
then you cannot redo any undos before then."</span>
  (interactive <span class="string">"*p"</span>)
  (<span class="keyword elisp">if</span> (eq buffer-undo-list t)
      (redo-error <span class="string">"No undo information in this buffer"</span>))
  (<span class="keyword elisp">if</span> (eq last-buffer-undo-list nil)
      (redo-error <span class="string">"No undos to redo"</span>))
  (or (eq last-buffer-undo-list buffer-undo-list)
      <span class="comment">;; skip one undo boundary and all point setting commands up</span>
      <span class="comment">;; until the next undo boundary and try again.</span>
      (<span class="keyword elisp">let</span> ((p buffer-undo-list))
	(and (null (car-safe p)) (setq p (cdr-safe p)))
	(<span class="keyword elisp">while</span> (and p (integerp (car-safe p)))
	  (setq p (cdr-safe p)))
	(eq last-buffer-undo-list p))
      (redo-error <span class="string">"Buffer modified since last undo/redo, cannot redo"</span>))
  (and (eq (cdr buffer-undo-list) pending-undo-list)
       (redo-error <span class="string">"No further undos to redo in this buffer"</span>))
  <span class="comment">;; This message seems to be unnecessary because the echo area</span>
  <span class="comment">;; is rewritten before the screen is updated.</span>
  <span class="comment">;;(or (eq (selected-window) (minibuffer-window))</span>
  <span class="comment">;;    (message <span class="string">"Redo..."</span>))</span>
  (<span class="keyword elisp">let</span> ((modified (buffer-modified-p))
	(undo-in-progress t)
	(recent-save (recent-auto-save-p))
	(old-undo-list buffer-undo-list)
	(p buffer-undo-list)
	(q (or pending-undo-list t))
	(records-between 0)
	(prev nil) next)
    <span class="comment">;; count the number of undo records between the head of the</span>
    <span class="comment">;; undo chain and the pointer to the next change.  Note that</span>
    <span class="comment">;; by `<span class="constant important">record</span>' we mean clumps of change records, not the</span>
    <span class="comment">;; boundary records.  The number of records will always be a</span>
    <span class="comment">;; multiple of 2, because an undo moves the pending pointer</span>
    <span class="comment">;; forward one record and prepend a record to the head of the</span>
    <span class="comment">;; chain.  Thus the separation always increases by two.  When</span>
    <span class="comment">;; we decrease it we will decrease it by a multiple of 2</span>
    <span class="comment">;; also.</span>
    (<span class="keyword elisp">while</span> p
      (setq next (cdr p))
      (<span class="keyword elisp">cond</span> ((eq next q)
	     <span class="comment">;; insert the unmodified status entry into undo records</span>
	     <span class="comment">;; if buffer is not modified.  The undo command inserts</span>
	     <span class="comment">;; this information only in redo entries.</span>
	     (<span class="keyword cl">when</span> (and (not modified) (buffer-file-name))
	       (<span class="keyword elisp">let</span>* ((time (nth 5 (file-attributes (buffer-file-name))))
		      (elt (<span class="keyword elisp">if</span> (cddr time) <span class="comment">;; non-nil means length &gt; 2</span>
			       time                           <span class="comment">;; Emacs 24</span>
			     (cons (car time) (cadr time))))) <span class="comment">;; Emacs 21-23</span>
		 (<span class="keyword elisp">if</span> (eq (car-safe (car prev)) t)
		     (setcdr (car prev) elt)
		   (setcdr prev (cons (cons t elt) p)))))
	     (setq next nil))
	    ((null (car next))
	     (setq records-between (1+ records-between))))
      (setq prev p
	    p next))
    <span class="comment">;; don't allow the user to redo more undos than exist.</span>
    <span class="comment">;; only half the records between the list head and the pending</span>
    <span class="comment">;; pointer are undos that are a part of this command chain.</span>
    (setq count (min (/ records-between 2) count)
	  p (primitive-undo (1+ count) buffer-undo-list))
    (<span class="keyword elisp">if</span> (eq p old-undo-list)
	nil <span class="comment">;; nothing happened</span>
      <span class="comment">;; set buffer-undo-list to the new undo list.  if has been</span>
      <span class="comment">;; shortened by `<span class="constant important">count</span>' records.</span>
      (setq buffer-undo-list p)
      <span class="comment">;; primitive-undo returns a list without a leading undo</span>
      <span class="comment">;; boundary.  add one.</span>
      (undo-boundary)
      <span class="comment">;; now move the pending pointer backward in the undo list</span>
      <span class="comment">;; to reflect the redo.  sure would be nice if this list</span>
      <span class="comment">;; were doubly linked, but no... so we have to run down the</span>
      <span class="comment">;; list from the head and stop at the right place.</span>
      (<span class="keyword elisp">let</span> ((n (- records-between count)))
	(setq p (cdr old-undo-list))
	(<span class="keyword elisp">while</span> (and p (&gt; n 0))
	  (setq p (cdr (memq nil p))
		n (1- n)))
	(setq pending-undo-list p)))
    (and modified (not (buffer-modified-p))
	 (delete-auto-save-file-if-necessary recent-save))
    (or (eq (selected-window) (minibuffer-window))
	(message <span class="string">"Redo!"</span>))
    (setq last-buffer-undo-list buffer-undo-list)))

(<span class="keyword">defun</span> <span class="function">undo</span> (<span class="type">&amp;optional</span> arg)
  <span class="string">"Undo some previous changes.
Repeat this command to undo more changes.
A numeric argument serves as a repeat count."</span>
  (interactive <span class="string">"*p"</span>)
  (<span class="keyword elisp">let</span> ((modified (buffer-modified-p))
	(recent-save (recent-auto-save-p)))
    <span class="comment">;; This message seems to be unnecessary because the echo area</span>
    <span class="comment">;; is rewritten before the screen is updated.</span>
    <span class="comment">;;(or (eq (selected-window) (minibuffer-window))</span>
    <span class="comment">;;    (message <span class="string">"Undo..."</span>))</span>
    (<span class="keyword elisp">let</span> ((p buffer-undo-list)
	  (old-pending-undo-list pending-undo-list))
      (or (eq last-buffer-undo-list buffer-undo-list)
	  <span class="comment">;; skip one undo boundary and all point setting commands up</span>
	  <span class="comment">;; until the next undo boundary and try again.</span>
	  (<span class="keyword elisp">progn</span> (and (null (car-safe p)) (setq p (cdr-safe p)))
		 (<span class="keyword elisp">while</span> (and p (integerp (car-safe p)))
		   (setq p (cdr-safe p)))
		 (eq last-buffer-undo-list p))
	  (<span class="keyword elisp">progn</span> (undo-start)
		 <span class="comment">;; get rid of initial undo boundary</span>
		 (undo-more 1)
		 (not undo-no-redo))
	  <span class="comment">;; discard old redo information if undo-no-redo is non-nil</span>
	  (<span class="keyword elisp">progn</span> (<span class="keyword elisp">if</span> (car-safe last-buffer-undo-list)
		     (<span class="keyword elisp">while</span> (and p (not (eq last-buffer-undo-list
					    (cdr-safe p))))
		       (setq p (cdr-safe p)))
		   (setq p last-buffer-undo-list))
		 (<span class="keyword elisp">if</span> p (setcdr p old-pending-undo-list)))
	  ))
    (undo-more (or arg 1))
    <span class="comment">;; Don't specify a position in the undo record for the undo command.</span>
    <span class="comment">;; Instead, undoing this should move point to where the change is.</span>
    <span class="comment">;;</span>
    <span class="comment">;;;; The old code for this was mad!  It deleted all set-point</span>
    <span class="comment">;;;; references to the position from the whole undo list,</span>
    <span class="comment">;;;; instead of just the cells from the beginning to the next</span>
    <span class="comment">;;;; undo boundary.  This does what I think the other code</span>
    <span class="comment">;;;; meant to do.</span>
    (<span class="keyword elisp">let</span>* ((p buffer-undo-list)
	   (list (cons nil p))
	   (prev list))
      (<span class="keyword elisp">while</span> (car p)
	(<span class="keyword elisp">if</span> (integerp (car p))
	    (setcdr prev (cdr p))
	  (setq prev p))
	(setq p (cdr p)))
      (setq buffer-undo-list (cdr list)))
    (and modified (not (buffer-modified-p))
	 (delete-auto-save-file-if-necessary recent-save)))
  (or (eq (selected-window) (minibuffer-window))
      (message <span class="string">"Undo!"</span>))
  (setq last-buffer-undo-list buffer-undo-list))

<span class="comment">;; Modify menu-bar and tool-bar item of GNU Emacs</span>
(<span class="keyword cl">unless</span> (<span class="keyword">featurep</span> '<span class="constant">xemacs</span>)
  <span class="comment">;; condition to undo</span>
  (mapc (<span class="keyword elisp">lambda</span> (map)
	  (<span class="keyword elisp">let</span>* ((p (assq 'undo (cdr map)))
		 (l (memq <span class="builtin">:enable</span> (setcdr p (copy-sequence (cdr p))))))
	    (<span class="keyword cl">when</span> l
	      (setcar (cdr l)
		      '(and (not buffer-read-only)
			    (consp buffer-undo-list)
			    (or (not (or (eq last-buffer-undo-list
					     buffer-undo-list)
					 (eq last-buffer-undo-list
					     (cdr buffer-undo-list))))
				(listp pending-undo-list)))))))
	(append (list menu-bar-edit-menu)
		(<span class="keyword elisp">if</span> window-system (list tool-bar-map))))
  <span class="comment">;; redo's menu-bar entry</span>
  (define-key-after menu-bar-edit-menu [redo]
    '(menu-item <span class="string">"Redo"</span> redo
		<span class="builtin">:enable</span>
		(and
		 (not buffer-read-only)
		 (not (eq buffer-undo-list t))
		 (not (eq last-buffer-undo-list nil))
		 (or (eq last-buffer-undo-list buffer-undo-list)
		     (<span class="keyword elisp">let</span> ((p buffer-undo-list))
		       (and (null (car-safe p)) (setq p (cdr-safe p)))
		       (<span class="keyword elisp">while</span> (and p (integerp (car-safe p)))
			 (setq p (cdr-safe p)))
		       (eq last-buffer-undo-list p)))
		 (not (eq (cdr buffer-undo-list) pending-undo-list)))
		<span class="builtin">:help</span> <span class="string">"Redo the most recent undo"</span>)
    'undo)
  <span class="comment">;; redo's tool-bar icon</span>
  (<span class="keyword cl">when</span> window-system
    (tool-bar-add-item-from-menu
     'redo <span class="string">"redo"</span> nil
     <span class="builtin">:visible</span> '(not (eq 'special (get major-mode 'mode-class))))
    (define-key-after tool-bar-map [redo]
      (cdr (assq 'redo tool-bar-map)) 'undo)
    <span class="comment">;; use gtk+ icon if Emacs23</span>
    (<span class="keyword elisp">if</span> (boundp 'x-gtk-stock-map)
	(setq x-gtk-stock-map
	      (cons '(<span class="string">"etc/images/redo"</span> . <span class="string">"gtk-redo"</span>) x-gtk-stock-map)))
    <span class="comment">;; update tool-bar icon immediately</span>
    (<span class="keyword">defun</span> <span class="function">redo-toolbar-update</span> (<span class="type">&amp;optional</span> bgn end lng)
      (interactive)
      (set-buffer-modified-p (buffer-modified-p)))
    (add-hook 'after-change-functions 'redo-toolbar-update))
  )

(<span class="keyword">provide</span> '<span class="constant">redo+</span>)

<span class="comment">;;; redo+.el ends here</span></pre></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="translation bar"><br />  <a href="http://www.emacswiki.org/emacs?action=translate;id=redo+.el;missing=de_es_fr_it_ja_ko_pt_ru_se_uk_zh" rel="nofollow" class="translation new">Add Translation</a></span><div class="edit bar"><a href="http://www.emacswiki.org/emacs/Comments_on_redo%2b.el" accesskey="c" class="comment local">Comments on redo+.el</a> <a accesskey="e" class="edit" href="http://www.emacswiki.org/emacs?action=edit;id=redo%2b.el" rel="nofollow" title="Click to edit this page">Edit this page</a> <a href="http://www.emacswiki.org/emacs?action=history;id=redo%2b.el" rel="nofollow" class="history">View other revisions</a> <a href="http://www.emacswiki.org/emacs?action=admin;id=redo%2b.el" rel="nofollow" class="admin">Administration</a></div><div class="time">Last edited 2013-11-17 11:51 UTC by <a class="author" title="wmx-pvt-186-183-224-119.kualnet.jp" href="http://www.emacswiki.org/emacs/irie">irie</a> <a class="diff" href="http://www.emacswiki.org/emacs?action=browse;diff=2;id=redo%2b.el" rel="nofollow">(diff)</a></div><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a class="licence" href="http://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="http://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="http://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="http://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="http://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="http://creativecommons.org/">CreativeCommons</a>
<a href="http://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
</div>
</body>
</html>

