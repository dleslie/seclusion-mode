;;; seclusion-mode.el --- Not actually a major/minor mode, but a frame configuration for total seclusion. A new frame is opened on the current buffer with as little clutter as possible and in fullscreen.

;; Copyright 2012 Daniel Leslie
;; Author: Daniel Leslie
;; URL: http://github.com/dleslie/seclusion-mode
;; Version: 1.0.0

;; Licensed under the GPL3
;; A copy of the license can be found at the above URL

(defun seclusion-mode (command)
      "Window mode to hide all the clutter and help you focus."
      (interactive "CEnter command to run:")
      ;; New window
      (select-frame (new-frame '((menu-bar-lines . 0) (minibuffer . nil) (toolbar . nil))))
      ;; Execute the user command, but don't trip and fall on it
      (condition-case err
          (call-interactively command)
          (error (princ (format "Error occurred in executing Theatre command: %s" err))))
      ;; Go full screen (Emacs 24+)
      (set-frame-parameter nil 'fullscreen (when (not (frame-parameter nil 'fullscreen)) 'fullboth))
      ;; Make some nice fat fringes
      (let* ((dim (window-pixel-edges))
             (size (/ (- (nth 2 dim) (nth 0 dim)) 4)))
        (set-window-fringes nil size size))
      ;; Kill the mode line
      (setq mode-line-format nil)
      ;; Kill the fringe clutter
      (setq fringe-indicator-alist '((truncation . nil)
                                     (continuation . nil)
                                     (up . nil) (down . nil) (top . nil) (bottom . nil) (top-bottom .nil)
                                     (empty-line . nil)
                                     (overlay-arrow . nil))))

(provide 'seclusion-mode)

;;; seclusion-mode.el ends here
