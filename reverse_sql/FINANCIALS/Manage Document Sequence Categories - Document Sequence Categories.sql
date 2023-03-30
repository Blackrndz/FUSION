/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Document%20Sequence%20Categories%20-%20Document%20Sequence%20Categories.sql $:
 * $Id: Manage Document Sequence Categories - Document Sequence Categories.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT ApplicationPEO.application_name RES_APPLICATION
,DocSequenceCategoriesEO.CODE RES_CATEGORY_CODE
,DOCSEQUENCECATEGORIESEO.NAME RES_CATEGORY_NAME
,APPLTAXONOMYPEO.USER_MODULE_NAME RES_MODULE
,DOCSEQUENCECATEGORIESEO.TABLE_NAME RES_TABLE
,DOCSEQUENCECATEGORIESEO.DESCRIPTION RES_DESCRIPTION
,DocSequenceCategoriesEO.LAST_UPDATED_BY   RSC_LAST_UPDATED_BY
,DocSequenceCategoriesEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,DocSequenceCategoriesEO.CREATED_BY RSC_CREATED_BY
,DocSequenceCategoriesEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,DocSequenceCategoriesEO.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DOC_SEQUENCE_CATEGORIES DocSequenceCategoriesEO
,FND_APPL_TAXONOMY_VL APPLTAXONOMYPEO
,fnd_application_vl ApplicationPEO
WHERE DOCSEQUENCECATEGORIESEO.MODULE_ID = APPLTAXONOMYPEO.MODULE_ID
and DocSequenceCategoriesEO.APPLICATION_ID = ApplicationPEO.APPLICATION_ID
ORDER BY DOCSEQUENCECATEGORIESEO.CODE
,DocSequenceCategoriesEO.APPLICATION_ID