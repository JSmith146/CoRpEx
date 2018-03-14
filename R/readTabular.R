#' @title Reproduction of the readTabular from the tm package
#' @description Return a function which reads in a text document from a tabular data structure (like a data frame or a list matrix) with knowledge about its internal structure and possible available metadata as specified by a so-called mapping.
#' @param mapping A named list of characters. The constructed reader will map each character entry to the content or metadatum of the text document as specified by the named list entry. Valid names include content to access the document's content, and character strings which are mapped to metadata entries.
#' @return Formally this function is a function generator, i.e., it returns a function (which reads in a text document) with a well-defined signature, but can access passed over arguments (e.g., the mapping) via lexical scoping.
#' @export
readTabular<- function (mapping){
  stopifnot(is.list(mapping))
  function(elem, language, id) {
    meta <- lapply(mapping[setdiff(names(mapping), "content")], 
                   function(m) elem$content[, m])
    if (is.null(meta$id)) 
      meta$id <- as.character(id)
    if (is.null(meta$language)) 
      meta$language <- as.character(language)
    PlainTextDocument(elem$content[, mapping$content], meta = meta)
  }
}