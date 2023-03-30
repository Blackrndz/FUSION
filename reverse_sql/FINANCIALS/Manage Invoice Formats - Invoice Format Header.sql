/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Invoice%20Formats%20-%20Invoice%20Format%20Header.sql $:
 * $Id: Manage Invoice Formats - Invoice Format Header.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT pjbINVOICEformatEO.NAME	RES_NAME
,(SELECT MEANING FROM FND_LOOKUPS 
			WHERE LOOKUP_CODE = pjbINVOICEformatEO.INVOICE_FORMAT_TYPE
				AND LOOKUP_TYPE = 'PJB_INVOICE_FORMAT_TYPE' )   RES_FORMAT_TYPE  
,TO_CHAR(pjbINVOICEformatEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(pjbINVOICEformatEO.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,(SELECT NAME FROM PJB_INV_GROUP_HEADERS 
			WHERE INVOICE_GROUP_ID = pjbINVOICEformatEO.INVOICE_GROUP_ID )  RES_GROUPING_OPTION 
,DECODE(pjbINVOICEformatEO.CUSTOMER_INVOICE_FLAG,'Y','Yes','No')	RES_CUSTOMER_INVOICES
,DECODE(pjbINVOICEformatEO.INTERNAL_INVOICE_FLAG,'Y','Yes','No') RES_INTERNAL_INVOICES
,DECODE(pjbINVOICEformatEO.FIXED_FORMAT_FLAG,'Y','Yes','No') RES_FIXED_FORMAT
,pjbINVOICEformatEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pjbINVOICEformatEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pjbINVOICEformatEO.CREATED_BY RSC_CREATED_BY
,pjbINVOICEformatEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJB_INVOICE_FORMATS pjbINVOICEformatEO
ORDER BY pjbINVOICEformatEO.NAME


