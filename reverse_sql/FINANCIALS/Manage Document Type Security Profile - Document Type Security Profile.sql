/* ****************************************************************************
 * $Revision: 71992 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2019-05-08 10:45:27 +0700 (Wed, 08 May 2019) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Absence%20Reasons%20-%20Absence%20Reason.sql $:
 * $Id: Manage Absence Reasons - Absence Reason.sql 71992 2019-05-08 03:45:27Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT docSecProfsE0.NAME RES_NAME
,DECODE(docSecProfsE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'INCLUDE_EXCLUDE'
    AND LOOKUP_CODE = docSecProfsE0.INCLUDE_EXCLUDE_FLAG
    ) RES_INCLUDE_OR_EXCLUDE_DOCUMEN
,docSecProfsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,docSecProfsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,docSecProfsE0.CREATED_BY RSC_CREATED_BY
,docSecProfsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_DOC_TYPE_SECURITY_PROFILES docSecProfsE0
ORDER BY docSecProfsE0.NAME