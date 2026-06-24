{
  pkgs,
  ...
}: {
  # Nyxt browser configuration via Home Manager
  programs.nyxt = {
    enable = true;
    config = ''
      (in-package :nyxt-user)

      ;; Enable Vim (VI) bindings and adblocking by default on all web pages
      (define-configuration web-buffer
        ((default-modes (append '(nyxt/mode/vi:vi-normal-mode
                                  nyxt/mode/blocker:blocker-mode
                                  nyxt/mode/reduce-tracking:reduce-tracking-mode
                                  nyxt/mode/force-https:force-https-mode)
                                %slot-value%))))

      ;; Load uBlock Origin and EasyList rules dynamically into Nyxt's blocker-mode
      (define-configuration nyxt/mode/blocker:blocker-mode
        ((nyxt/mode/blocker:hostlists
          (append
           (list (make-instance 'nyxt/mode/blocker:hostlist
                                :url (quri:uri "https://easylist.to/easylist/easylist.txt")
                                :name "EasyList")
                 (make-instance 'nyxt/mode/blocker:hostlist
                                :url (quri:uri "https://easylist.to/easylist/easyprivacy.txt")
                                :name "EasyPrivacy")
                 (make-instance 'nyxt/mode/blocker:hostlist
                                :url (quri:uri "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt")
                                :name "uBlock Filters")
                 (make-instance 'nyxt/mode/blocker:hostlist
                                :url (quri:uri "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt")
                                :name "uBlock Privacy")
                 (make-instance 'nyxt/mode/blocker:hostlist
                                :url (quri:uri "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt")
                                :name "uBlock Badware")
                 (make-instance 'nyxt/mode/blocker:hostlist
                                :url (quri:uri "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt")
                                :name "uBlock Unbreak"))
           %slot-value%))))
    '';
  };
}
