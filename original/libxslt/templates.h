/*
 * templates.h: interface for the template processing
 *
 * See Copyright for the status of this software.
 *
 * daniel@veillard.com
 */

#ifndef __XML_XSLT_TEMPLATES_H__
#define __XML_XSLT_TEMPLATES_H__

#include <libxml/xpath.h>
#include <libxml/xpathInternals.h>
#include "xsltexports.h"
#include "xsltInternals.h"

#ifdef __cplusplus
extern "C" {
#endif

XSLTPUBFUN int XSLTCALL		
		xsltEvalXPathPredicate		(xsltTransformContextPtr ctxt,
						 xmlXPathCompExprPtr comp,
		                                 xmlNsPtr *nsList,
						 int nsNr);
XSLTPUBFUN xmlChar * XSLTCALL	
		xsltEvalTemplateString		(xsltTransformContextPtr ctxt,
						 xmlNodePtr node,
						 xmlNodePtr parent);
XSLTPUBFUN xmlChar * XSLTCALL	
		xsltEvalAttrValueTemplate	(xsltTransformContextPtr ctxt,
						 xmlNodePtr node,
						 const xmlChar *name,
						 const xmlChar *ns);
XSLTPUBFUN xmlChar * XSLTCALL	
		xsltEvalStaticAttrValueTemplate	(xsltStylesheetPtr style,
						 xmlNodePtr node,
						 const xmlChar *name,
						 const xmlChar *ns,
						 int *found);

/* TODO: this is obviously broken ... the namespaces should be passed too ! */
XSLTPUBFUN xmlChar * XSLTCALL	
		xsltEvalXPathString		(xsltTransformContextPtr ctxt,
						 xmlXPathCompExprPtr comp);
XSLTPUBFUN xmlChar * XSLTCALL	
		xsltEvalXPathStringNs		(xsltTransformContextPtr ctxt,
						 xmlXPathCompExprPtr comp,
						 int nsNr,
						 xmlNsPtr *nsList);

XSLTPUBFUN xmlNodePtr * XSLTCALL	
		xsltTemplateProcess		(xsltTransformContextPtr ctxt,
						 xmlNodePtr node);
XSLTPUBFUN xmlAttrPtr XSLTCALL	
		xsltAttrListTemplateProcess	(xsltTransformContextPtr ctxt,
						 xmlNodePtr target,
						 xmlAttrPtr cur);
XSLTPUBFUN xmlAttrPtr XSLTCALL	
		xsltAttrTemplateProcess		(xsltTransformContextPtr ctxt,
						 xmlNodePtr target,
						 xmlAttrPtr attr);
XSLTPUBFUN xmlChar * XSLTCALL	
		xsltAttrTemplateValueProcess	(xsltTransformContextPtr ctxt,
						 const xmlChar* attr);
XSLTPUBFUN xmlChar * XSLTCALL	
		xsltAttrTemplateValueProcessNode(xsltTransformContextPtr ctxt,
						 const xmlChar* str,
						 xmlNodePtr node);
#ifdef __cplusplus
}
#endif

#endif /* __XML_XSLT_TEMPLATES_H__ */
