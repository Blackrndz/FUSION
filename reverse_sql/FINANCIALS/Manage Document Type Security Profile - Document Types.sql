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
,docsE0.DOCUMENT_TYPE RES_TYPE
,NVL((SELECT TERRITORY_SHORT_NAME
    FROM FND_TERRITORIES_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND TERRITORY_CODE = docsE0.LEGISLATION_CODE
    ),'All Countries') RES_COUNTRY
,DocTypesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,DocTypesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,DocTypesE0.CREATED_BY RSC_CREATED_BY
,DocTypesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_DOC_TYPE_SECURITY_PROFILES docSecProfsE0
,PER_DOC_TYPE_SEC_PROF_DOCTYPES DocTypesE0
,HR_DOCUMENT_TYPES_VL docsE0
WHERE docSecProfsE0.DOC_TYPE_SECURITY_PROFILE_ID = DocTypesE0.DOC_TYPE_SECURITY_PROFILE_ID
AND DocTypesE0.DOCUMENT_TYPE_ID = docsE0.DOCUMENT_TYPE_ID
ORDER BY docSecProfsE0.NAME