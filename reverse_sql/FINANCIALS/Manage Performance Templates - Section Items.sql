/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT pfTemplatesE0.NAME RES_NAME
,(SELECT NAME
    FROM HRT_CONTENT_ITEMS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND CONTENT_ITEM_ID = sectionItemsE0.CONTENT_ITEM_ID
    ) RES_ITEM_NAME

,sectionItemsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,sectionItemsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,sectionItemsE0.CREATED_BY  RSC_CREATED_BY
,sectionItemsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
  

FROM HRA_TMPL_DEFNS_VL pfTemplatesE0
,HRA_TMPL_SECTIONS tempSectionsE0
,HRA_TMPL_SEC_ITEMS sectionItemsE0
WHERE pfTemplatesE0.TEMPLATE_DEFN_ID = tempSectionsE0.TEMPLATE_DEFN_ID
AND tempSectionsE0.SECTION_ID = sectionItemsE0.SECTION_ID
ORDER BY pfTemplatesE0.NAME
,tempSectionsE0.SEQUENCE_NUMBER