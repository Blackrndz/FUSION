/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=IRC_APPLY_FLOWS_VL

SELECT flowsE0.APPLY_FLOW_NAME RES_APPLICATION_FLOW_NAME
,versionsE0.VERSION_NAME RES_VERSION_NAME
,blocksE0.BLOCK_NAME RES_MORE_ABOUT_YOU
/*,sectionsE0.SECTION_NAME
,blocksE0.BLOCK_NAME
,pageBlocksE0.PAGE_BLOCK_TITLE
,pageBlocksE0.PAGE_BLOCK_INSTRUCTIONS*/
,pageBlocksE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pageBlocksE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pageBlocksE0.CREATED_BY RSC_CREATED_BY
,pageBlocksE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IRC_APPLY_FLOWS_VL flowsE0
,IRC_AF_VERSIONS versionsE0
,IRC_AF_SECTIONS_VL sectionsE0
,IRC_AF_PAGES_VL pagesE0
,IRC_AF_PAGE_BLOCKS_VL pageBlocksE0
,IRC_AF_BLOCKS_VL blocksE0
WHERE flowsE0.APPLY_FLOW_ID = versionsE0.APPLY_FLOW_ID
AND versionsE0.AF_VERSION_ID = sectionsE0.AF_VERSION_ID
AND sectionsE0.SECTION_ID = pagesE0.SECTION_ID
AND pagesE0.PAGE_ID = pageBlocksE0.PAGE_ID
AND pageBlocksE0.BLOCK_ID = blocksE0.BLOCK_ID

AND sectionsE0.SECTION_NAME = 'More About You'

ORDER BY flowsE0.APPLY_FLOW_NAME
,versionsE0.VERSION_NAME
,sectionsE0.SECTION_SEQ_NUM
,pagesE0.PAGE_SEQ_NUM
,pageBlocksE0.PAGE_BLOCK_SEQ_NUM