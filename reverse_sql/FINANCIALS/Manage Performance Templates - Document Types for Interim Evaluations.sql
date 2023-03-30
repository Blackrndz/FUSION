/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 -- RSC_PREREQUISITE_OBJECTS = HRA_TMPL_PERIOD_DOC_TYPES
 
SELECT pfTemplatesE0.NAME RES_NAME
,docPeriodsE0.CUSTOMARY_NAME RES_PERIOD_NAME
,(SELECT NAME
    FROM HRA_DOC_TYPES_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND DOC_TYPE_ID = docTypePeriodsE0.DOC_TYPE_ID
    ) RES_DOCUMENT_TYPE
,docTypePeriodsE0.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,docTypePeriodsE0.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,docTypePeriodsE0.CREATED_BY  RSC_CREATED_BY
,docTypePeriodsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRA_TMPL_DEFNS_VL pfTemplatesE0
,HRA_TMPL_PERIODS_VL docPeriodsE0
,HRA_TMPL_PERIOD_DOC_TYPES docTypePeriodsE0
WHERE pfTemplatesE0.TEMPLATE_DEFN_ID = docPeriodsE0.TEMPLATE_DEFN_ID
AND docPeriodsE0.TMPL_PERIOD_ID = docTypePeriodsE0.TMPL_PERIOD_ID
ORDER BY pfTemplatesE0.NAME